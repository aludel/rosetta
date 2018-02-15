#!/usr/bin/perl

use strict;
use warnings;
require "RPNparser.pl";

#
# let's try it...
#

my $test = "2 3 - 6 3 + * 5 * 100 +"; # ((2 - 3) * (6 + 3) * 5) + 100
(parser($test) == 55) ? print "OK\n" : print "KO\n";
