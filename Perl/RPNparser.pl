#!/usr/bin/perl

#
# simple Reverse Polish Notation parser (only positive integers and + - * : allowed)
#
# inspired by http://lukaszwrobel.pl/blog/reverse-polish-notation-parser (in Ruby)
#

use strict;
use warnings;

sub parser {
	my @stack = [];
	my @array = split (' ', $_[0]);

	if ($#array == 0) {
		print "EMPTY EXPRESSION\n";
		exit 1;
	} elsif ($#array == 1) {
		if ($array[0] =~ m/\d+/) {
			return $array[0];
		} else {
			print "SYNTAX ERROR\n";
			exit 2;
		}
	}

	foreach my $token (@array) {
		if ($token =~ m/\d+/) {
			push (@stack, $token);
		} elsif ($token =~ m/(\+|-|\*|:)/) {
			my $x;
			my $y;
			my $res;

			if ($#stack < 2) {
				print "SYNTAX ERROR\n";
				exit 2;
			}

			$y = pop (@stack);
			$x = pop (@stack);

			if ($token =~ m/\+/) {
				$res = $x + $y;
			} elsif ($token =~ m/-/) {
				$res = $x - $y;
			} elsif ($token =~ m/\*/) {
				$res = $x * $y;
			} elsif ($token =~ m/:/) {
				$res = $x / $y;
			}

			push (@stack, $res);
		} else {
			print "SYNTAX ERROR\n";
			exit 2;
		}
	}

	if ($#stack != 1) {
		print "SYNTAX ERROR\n";
		exit 2;
	}

	return pop (@stack);
}

1;

