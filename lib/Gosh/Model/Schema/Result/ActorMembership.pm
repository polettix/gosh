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

=head2 member

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 itsgroup

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "member",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "itsgroup",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<member_itsgroup_unique>

=over 4

=item * L</member>

=item * L</itsgroup>

=back

=cut

__PACKAGE__->add_unique_constraint("member_itsgroup_unique", ["member", "itsgroup"]);

=head1 RELATIONS

=head2 itsgroup

Type: belongs_to

Related object: L<Gosh::Model::Schema::Result::Actor>

=cut

__PACKAGE__->belongs_to(
  "itsgroup",
  "Gosh::Model::Schema::Result::Actor",
  { id => "itsgroup" },
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
  { id => "member" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-06 06:15:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FxEHwRsS+YvtcMRKGP9emw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
