use utf8;
package Gosh::Model::Schema::Result::Register;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Gosh::Model::Schema::Result::Register

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<register>

=cut

__PACKAGE__->table("register");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 activity

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 actor

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 itsdate

  data_type: 'text'
  is_nullable: 1

=head2 amount

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "activity",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "actor",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "itsdate",
  { data_type => "text", is_nullable => 1 },
  "amount",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 activity

Type: belongs_to

Related object: L<Gosh::Model::Schema::Result::Activity>

=cut

__PACKAGE__->belongs_to(
  "activity",
  "Gosh::Model::Schema::Result::Activity",
  { id => "activity" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 actor

Type: belongs_to

Related object: L<Gosh::Model::Schema::Result::Actor>

=cut

__PACKAGE__->belongs_to(
  "actor",
  "Gosh::Model::Schema::Result::Actor",
  { id => "actor" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-06 06:11:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zDWA2MzWYiFGMQjjXQ51vg

sub as_hash {
   my $self = shift;
   my %retval = $self->get_columns();
   $retval{activity} = $self->activity()->as_hash();
   $retval{actor} = $self->actor()->as_hash();
   return \%retval;
}

1;
