#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/1
# https://adventofcode.com/2021/day/1/input
# Usage: day01.pl < FILE

use v5.28;
use warnings;

my($prev, $count) = (~0, 0);
my($int, $line);

while ($line = <STDIN>) {
	chomp $line;
	warn "non-numeric input" if $line =~ /[^\d]/;

	$int = int $line;
	$count++ if $int > $prev;
	$prev = $int;
}

# output bare number of times that output increased over previous line
say $count;
