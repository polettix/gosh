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

=head2 item_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "group_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "item_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<group_id_item_id_unique>

=over 4

=item * L</group_id>

=item * L</item_id>

=back

=cut

__PACKAGE__->add_unique_constraint("group_id_item_id_unique", ["group_id", "item_id"]);

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

=head2 item

Type: belongs_to

Related object: L<Gosh::Model::Schema::Result::Actor>

=cut

__PACKAGE__->belongs_to(
  "item",
  "Gosh::Model::Schema::Result::Actor",
  { id => "item_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-06 03:50:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ucCV0I1fUwmQr5x4Y3257Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
