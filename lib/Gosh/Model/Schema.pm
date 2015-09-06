use utf8;
package Gosh::Model::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-06 03:50:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bT8N+Z7DwsHU4RW7t3eXfA

sub ensure {
   my ($self) = @_;
   my $storage = $self->storage();
   $storage->dbh_do(
      sub {
         my ($storage, $dbh) = @_;
         $dbh->do($_) for (
            '
               CREATE TABLE IF NOT EXISTS actor (
                           id INTEGER PRIMARY KEY,
                  displayname TEXT
               )
            ',
            '
               CREATE TABLE IF NOT EXISTS actor_membership (
                  group_id INTEGER references actor(id),
                  item_id INTEGER references actor(id),
                  UNIQUE(group_id, item_id)
               )
            ',
            '
               CREATE TABLE IF NOT EXISTS account (
                           id INTEGER PRIMARY KEY,
                     actor_id INTEGER REFERENCES actor(id),
                     username TEXT UNIQUE,
                     password TEXT,
                  displayname TEXT
               )
            ',
            '
               CREATE TABLE IF NOT EXISTS activity (
                           id INTEGER PRIMARY KEY,
                        name TEXT,
                  description TEXT
               )
            ',
            '
               CREATE TABLE IF NOT EXISTS catalog (
                  id INTEGER PRIMARY KEY,
                     actor_id INTEGER REFERENCES actor(id),
                  activity_id INTEGER REFERENCES activity(id),
                  date_start TEXT,
                     date_end TEXT,
                        value INTEGER
               )
            ',
            '
               CREATE TABLE IF NOT EXISTS register (
                  id INTEGER PRIMARY KEY,
                     actor_id INTEGER REFERENCES actor(id),
                  activity_id INTEGER REFERENCES activity(id),
                  date_start TEXT,
                     date_end TEXT,
                        value INTEGER
               )
            '
         );
      }
   );
}

1;
