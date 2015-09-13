#!/usr/bin/env wrapperl
use 5.018001;
use strict;
use warnings;

my $VERSION = '0.01';

use Log::Log4perl::Tiny qw< :easy :no_extra_logdie_message LOGLEVEL >;
Log::Log4perl->easy_init(
   {
      level    => $DEBUG,
      layout   => '[%d] [%-5P:%-5p] %m%n',
      channels => [
         fh => \*STDERR,
      ],
   }
);

require Mojolicious::Commands;
DEBUG "$0 version '$VERSION'";
Mojolicious::Commands->start_app('Gosh::REST');
