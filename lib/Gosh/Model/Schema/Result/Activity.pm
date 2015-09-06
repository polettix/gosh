use utf8;
package Gosh::Model::Schema::Result::Activity;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Gosh::Model::Schema::Result::Activity

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<activity>

=cut

__PACKAGE__->table("activity");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 catalogs

Type: has_many

Related object: L<Gosh::Model::Schema::Result::Catalog>

=cut

__PACKAGE__->has_many(
  "catalogs",
  "Gosh::Model::Schema::Result::Catalog",
  { "foreign.activity" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 registers

Type: has_many

Related object: L<Gosh::Model::Schema::Result::Register>

=cut

__PACKAGE__->has_many(
  "registers",
  "Gosh::Model::Schema::Result::Register",
  { "foreign.activity" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-06 06:11:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cr6BQxsFDRFoydlN0w+woA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
