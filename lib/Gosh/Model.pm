package Gosh::Model;

use strict;
use 5.018_001;
our $VERSION = '0.01';
use English qw< -no_match_vars >;

use Log::Log4perl::Tiny qw< :easy :dead_if_first >;
use Gosh::Model::Schema;
use Moo;

has dsn => (
   is      => 'ro',
   builder => 'BUILD_dsn',
   lazy    => 1,
);

has username => (
   is      => 'ro',
   builder => 'BUILD_username',
   lazy    => 1,
);

has password => (
   is      => 'ro',
   builder => 'BUILD_password',
   lazy    => 1,
);

has schema => (
   is      => 'ro',
   builder => 'BUILD_schema',
   lazy    => 1,
);

sub BUILD_dsn      { return 'dbi:SQLite:dbname=gosh.sqlite' }
sub BUILD_username { return '' }
sub BUILD_password { return '' }

sub BUILD_schema {
   my $self   = shift;
   my $dsn    = $self->dsn();
   my $user   = $self->username();
   my $pass   = $self->password();
   my $schema = Gosh::Model::Schema->connect($dsn, $user, $pass);
   $schema->ensure();
   return $schema;
} ## end sub BUILD_schema


sub actors_for_account {
   my ($self, $account) = @_;
   $account = $self->schema()->resultset('Account')->find($account)
      unless ref $account;
   INFO "got account: ", $account->displayname();
   my $actor = $account->actor();
   return ($actor, $actor->all_groups());
}

sub catalog_for_account {
   my ($self, $account, $best_between) = @_;

   # $better_between is a comparison function that returns the "best"
   # between two catalog items
   $best_between //= sub {
      $_[0]->amount() >= $_[1]->amount() ? $_[0] : $_[1]
   };

   # this will hold the result, also allowing us to efficiently compare
   # different alternative catalog items in order to always keep the
   # best one
   my %catalog;

   # we will analyze all catalogs from all actor groups we are part of
   my @actors = $self->actors_for_account($account);
   for my $actor (@actors) {
      for my $item ($actor->catalogs()) {
         my $id = $item->get_column('activity');
         if (exists $catalog{$id}) {
            $catalog{$id} = $best_between->($catalog{$id}, $item);
         }
         else {
            $catalog{$id} = $item;
         }
      }
   }

   # the catalog might be big... allow for returning an array reference
   # in scalar context (better: in non-list context)
   my @retval = values %catalog;
   return wantarray() ? @retval : \@retval;
}

sub plain_catalog_for_account {
   my $self = shift;
   my $catalog = $self->catalog_for_account(@_);
   my @retval = map {
      my $activity = $_->activity();
      {
         catalog_id => $_->id(),
         activity_id => $activity->id(),
         name => $activity->name(),
         amount => $_->amount(),
      }
   } @$catalog;
   return wantarray() ? @retval : \@retval;
}

'Lazyiness, Impatience, and Hubris';
__END__

=encoding utf-8

=head1 NAME

Gosh::Model - Model for gosh

=head1 SYNOPSIS

  use Gosh;

=head1 DESCRIPTION

Gosh is an attempt to gamify shared tasks, like housekeeping duties as
normally carried on by people living in the same house. Nothing prevents
you from using it for other purposes though!

=head1 AUTHOR

Flavio Poletti E<lt>polettix@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2015 Flavio Poletti

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the terms of the Artistic License 2.0.

=head1 SEE ALSO

=cut
