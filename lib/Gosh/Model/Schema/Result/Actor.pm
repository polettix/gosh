use utf8;
package Gosh::Model::Schema::Result::Actor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Gosh::Model::Schema::Result::Actor

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<actor>

=cut

__PACKAGE__->table("actor");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 displayname

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "displayname",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 accounts

Type: has_many

Related object: L<Gosh::Model::Schema::Result::Account>

=cut

__PACKAGE__->has_many(
  "accounts",
  "Gosh::Model::Schema::Result::Account",
  { "foreign.actor" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 actor_membership_itsgroups

Type: has_many

Related object: L<Gosh::Model::Schema::Result::ActorMembership>

=cut

__PACKAGE__->has_many(
  "actor_membership_itsgroups",
  "Gosh::Model::Schema::Result::ActorMembership",
  { "foreign.itsgroup" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 actor_membership_members

Type: has_many

Related object: L<Gosh::Model::Schema::Result::ActorMembership>

=cut

__PACKAGE__->has_many(
  "actor_membership_members",
  "Gosh::Model::Schema::Result::ActorMembership",
  { "foreign.member" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 catalogs

Type: has_many

Related object: L<Gosh::Model::Schema::Result::Catalog>

=cut

__PACKAGE__->has_many(
  "catalogs",
  "Gosh::Model::Schema::Result::Catalog",
  { "foreign.actor" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 registers

Type: has_many

Related object: L<Gosh::Model::Schema::Result::Register>

=cut

__PACKAGE__->has_many(
  "registers",
  "Gosh::Model::Schema::Result::Register",
  { "foreign.actor" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-06 06:15:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XLBiW6Iz6pg//+veK7E1Ag


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
