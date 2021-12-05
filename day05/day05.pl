#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/5
# https://adventofcode.com/2021/day/5/input
# Usage: day05.pl < FILE

use v5.28;
use warnings;
use List::Util 'reduce';

my @coords;
my @map;
my ($x1, $y1, $x2, $y2);
my $line;

while ($line = <STDIN>) {
	chomp $line;
	$line =~ /^(\d+),(\d+) -> (\d+),(\d+)$/ or warn 'unusual line';
	($x1, $y1, $x2, $y2) = map { int } ($1, $2, $3, $4);
	next unless ($x1 == $x2 or $y1 == $y2); # diagonal line

	($x1, $x2) = ($x2, $x1) if $x1 > $x2;
	($y1, $y2) = ($y2, $y1) if $y1 > $y2;

	for my $x ($x1 .. $x2) { # looks like n^2 but is actually O(n)
		for my $y ($y1 .. $y2) {
			$map[$x][$y]++;
		}
	}
}

say reduce { $a + scalar(grep {($_ // 0) > 1} @$b) } (0, @map);
