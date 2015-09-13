package Gosh::Util;

use strict;
use 5.018_001;
our $VERSION = '0.01';
use English qw< -no_match_vars >;

use Log::Log4perl::Tiny qw< :easy :dead_if_first >;

use Exporter 'import';
use POSIX qw< strftime >;

{
   our @EXPORT_OK = qw< now plainify normalize_or_now >;
   our @EXPORT = ();
   our %EXPORT_TAGS = (
      all => [ @EXPORT_OK ],
   );
}

sub now { return strftime '%Y-%m-%dT%H:%M:%SZ', gmtime() }
sub plainify { map { $_->as_hash() } @_ }

sub normalize_or_now {
   my ($date) = @_;
   my $now = now();
   return $now unless $date;

   return $date
      if $date =~ m{\A \d{4}-\d\d-\d\d T \d\d:\d\d:\d\d Z \z}mxs;

   my ($today) = split /T/, $now, 2;
   $date = "$3-$2-$1" if $date =~ m{\A (\d\d)-(\d\d)-(\d{4}) \z}mxs;
   INFO "[$date] vs [$today]";
   return $now
      if ($date eq $today) || ($date !~ m{\A \d{4}-\d\d-\d\d \z}mxs);
   return $date . 'T12:00:00Z';
}
