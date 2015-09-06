package Gosh::Util;

use strict;
use 5.018_001;
our $VERSION = '0.01';
use English qw< -no_match_vars >;

use Log::Log4perl::Tiny qw< :easy :dead_if_first >;

use Exporter 'import';
use POSIX qw< strftime >;

{
   our @EXPORT_OK = qw< now plainify >;
   our @EXPORT = ();
   our %EXPORT_TAGS = (
      all => [ @EXPORT_OK ],
   );
}

sub now { return strftime '%Y-%m-%dT%H:%M:%SZ', gmtime() }
sub plainify { map { $_->as_hash() } @_ }
