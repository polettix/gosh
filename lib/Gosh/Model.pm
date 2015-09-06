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

sub _get_it {
   my ($self, $type, $id) = @_;
   return $id if ref $id;
   return $self->schema()->resultset(ucfirst(lc($type)))->find($id);
}

sub account       { return $_[0]->_get_it(account  => $_[1]) }
sub activity      { return $_[0]->_get_it(activity => $_[1]) }
sub actor         { return $_[0]->_get_it(actor    => $_[1]) }
sub catalog_item  { return $_[0]->_get_it(catalog  => $_[1]) }
sub register_item { return $_[0]->_get_it(register => $_[1]) }


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
