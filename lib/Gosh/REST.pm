package Gosh::REST;

use strict;
use 5.018_001;
our $VERSION = '0.01';
use English qw< -no_match_vars >;

use Log::Log4perl::Tiny qw< :easy :dead_if_first LOGLEVEL >;
use Gosh::Model;
use Gosh::Util qw< plainify normalize_or_now >;
use Mojo::Base 'Mojolicious';
use YAML::Tiny;
use Data::Dumper;
$Data::Dumper::Indent = 1;

has 'model';

sub config {
   my $self = shift;
   my $filename = $ENV{GOSH_REST_CONFIG} // $self->moniker() . '.yml';
   return -e $filename ? YAML::Tiny::LoadFile($filename) : {};
}

sub startup {
   my $self = shift;

   $self->moniker('Gosh-REST');
   $self->secrets(['Il Carrozzone']);

   my $config = $self->config();
   LOGLEVEL(uc($config->{loglevel} // 'DEBUG'));

   my $model = Gosh::Model->new(%{$config->{model} // {}});
   $self->model($model);

   my $r = $self->routes();
   $r->get('/' => \&root);

   $r->get('/account'               => \&list_accounts);
   $r->get('/account/:aid'          => \&retrieve_account);
   $r->get('/account/:aid/catalog'  => \&list_catalog);
   $r->get('/account/:aid/register' => \&list_register);
   $r->post('/account/:aid/register' => \&create_registration);
   $r->options('/account/:aid/register' => \&create_registration_options);
   $r->delete('/register/:rid'              => \&delete_registration);
   $r->delete('/account/:aid/register/:rid' => \&delete_registration);

   return;
} ## end sub startup

sub root { return shift->render(text => "Howdy, all!\n") }

sub list_accounts {
   my $c    = shift;
   my $model = $c->app()->model();
   $c->render(json => {accounts => [plainify($model->accounts())]});
}

sub retrieve_account {
   my $c = shift;
   my $account = $c->app()->model()->account($c->param('aid'))
      or return _render($c, code => 404);
   $c->render(json => {account => $account->as_hash()});
}

sub list_catalog {
   my $c       = shift;
   my $account = $c->app()->model()->account($c->param('aid'))
      or return _render($c, code => 404);
   my @catalog =
      map  { $_->[1] }
      sort { $a->[0] <=> $b->[0] }
      map  { [$_->{id} => $_] }
      plainify($account->catalog());
   $c->render(json => {catalog => \@catalog});
}

sub list_register {
   my $c       = shift;
   my $account = $c->app()->model()->account($c->param('aid'))
      or return _render($c, code => 404);
   $c->render(json => {register => [plainify($account->register())]});
}

sub create_registration {
   my $c    = shift;
   my $account = $c->app()->model()->account($c->param('aid'))
      or return _render($c, code => 404);
   my $args = $c->req()->json();
   $args->{date} = normalize_or_now($args->{date});
   my $registration = $account->create_registration($args);
   $c->render(json => {registration => $registration->as_hash()});
}

sub create_registration_options {
   my $c = shift;
   DEBUG 'got here at least';
   $c->rendered(204);
   return;
}

sub delete_registration {
   my $c    = shift;
   if (my $reg = $c->app()->model()->register_item($c->param('rid'))) {
      $reg->delete();
   }
   return _render($c, code => 204);
}

sub _render {
   my ($c, %args) = @_;
   my $response = $c->res();
   my $headers = $response->headers();
   $headers->header(@$_) for @{$args{headers} // []};
   $response->body($args{body}) if defined $args{body};
   $c->rendered($args{code} // 500);
   return;
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

=head1 REST INTERFACE

=over

=item B<< GET /account >>

=item B<< GET /account/:aid >>

=item B<< GET /account/:aid/catalog >>

=item B<< GET /account/:aid/register >>

=item B<< POST /account/:aid/register >>

=item B<< DELETE /register/:rid >>

=item B<< DELETE /account/:aid/register/:rid >>

=back

=head1 AUTHOR

Flavio Poletti E<lt>polettix@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2015 Flavio Poletti

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the terms of the Artistic License 2.0.

=head1 SEE ALSO

=cut
