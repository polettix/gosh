use utf8;
package Gosh::Model::Schema::Result::Account;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Gosh::Model::Schema::Result::Account

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<account>

=cut

__PACKAGE__->table("account");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 actor

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 username

  data_type: 'text'
  is_nullable: 1

=head2 password

  data_type: 'text'
  is_nullable: 1

=head2 displayname

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "actor",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "username",
  { data_type => "text", is_nullable => 1 },
  "password",
  { data_type => "text", is_nullable => 1 },
  "displayname",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<username_unique>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("username_unique", ["username"]);

=head1 RELATIONS

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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jUFBNe+wEOuasnH++R/kUg

use Gosh::Util qw< now >;

sub schema { return shift->result_source()->schema() }

sub as_hash {
   my $self = shift;
   my %retval = $self->get_columns();
   $retval{actor} = $self->actor()->as_hash();
   return \%retval;
}

sub actors {
   my $actor = shift->actor();
   return ($actor, $actor->all_groups());
}

sub catalog {
   my ($self, $best_between) = @_;

   # $best_between is a comparison function that returns the "best"
   # between two catalog items
   $best_between //= sub {
      $_[0]->amount() >= $_[1]->amount() ? $_[0] : $_[1];
   };

   # this will hold the result, also allowing us to efficiently compare
   # different alternative catalog items in order to always keep the
   # best one
   my %catalog;

   # we will analyze all catalogs from all actor groups we are part of
   for my $actor ($self->actors()) {
      for my $item ($actor->catalogs()) {
         my $id = $item->get_column('activity');
         if (exists $catalog{$id}) {
            $catalog{$id} = $best_between->($catalog{$id}, $item);
         }
         else {
            $catalog{$id} = $item;
         }
      } ## end for my $item ($actor->catalogs...)
   } ## end for my $actor (@actors)

   # the catalog might be big... allow for returning an array reference
   # in scalar context (better: in non-list context)
   my @retval = values %catalog;
   return wantarray() ? @retval : \@retval;
}

sub create_registration {
   my $self = shift;
   my %args = (@_ && ref($_[0])) ? %{$_[0]} : @_;
   for my $key (qw< activity amount >) {
      die {message => "missing value for '$key'"}
         unless defined $args{$key};
   }
   return $self->schema()->resultset('Register')->create(
      {
         actor => $self->actor(),
         itsdate => $args{date} // now(),
         activity => $args{activity},
         amount => $args{amount},
      }
   );
}

sub register { return shift->actor()->registers() }

1;
