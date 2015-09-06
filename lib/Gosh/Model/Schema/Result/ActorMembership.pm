use utf8;
package Gosh::Model::Schema::Result::ActorMembership;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Gosh::Model::Schema::Result::ActorMembership

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<actor_membership>

=cut

__PACKAGE__->table("actor_membership");

=head1 ACCESSORS

=head2 group_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 member_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "group_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "member_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<group_id_member_id_unique>

=over 4

=item * L</group_id>

=item * L</member_id>

=back

=cut

__PACKAGE__->add_unique_constraint("group_id_member_id_unique", ["group_id", "member_id"]);

=head1 RELATIONS

=head2 group

Type: belongs_to

Related object: L<Gosh::Model::Schema::Result::Actor>

=cut

__PACKAGE__->belongs_to(
  "group",
  "Gosh::Model::Schema::Result::Actor",
  { id => "group_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 member

Type: belongs_to

Related object: L<Gosh::Model::Schema::Result::Actor>

=cut

__PACKAGE__->belongs_to(
  "member",
  "Gosh::Model::Schema::Result::Actor",
  { id => "member_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-06 05:32:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NPerVuEoB9a9Vg7LCPeArA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
