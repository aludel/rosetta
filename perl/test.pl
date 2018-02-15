#!/usr/bin/perl

use strict;
use warnings;
require "RPNparser.pl";

#
# let's try it...
#

my $test = "2 3 - 6 3 + * 5 * 100 +"; # ((2 - 3) * (6 + 3) * 5) + 100
print "OK\n" unless (parser($test) != 55);
