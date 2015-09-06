requires 'perl', '5.018001';
requires 'DBD::SQLite', '1.48';
requires 'DBI', '1.634';
requires 'Log::Log4perl::Tiny', '1.002007';
requires 'Moo', '2.000002';
requires 'DBIx::Class', '0.082820';
requires 'DBIx::Class::Schema::Loader', '0.07043';

on test => sub {
    requires 'Test::More', '0.96';
};
