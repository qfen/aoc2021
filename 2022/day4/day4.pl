#!/usr/bin/perl
use v5.18;
use warnings;

my ($part1, $part2);

while (<>) {
	/(\d+)-(\d+),(\d+)-(\d+)/ or die 'weird line';
	my ($a1, $a2, $b1, $b2) = map { int } $1, $2, $3, $4;

	$part1++ if ($b1 >= $a1 and $b2 <= $a2) or ($a1 >= $b1 and $a2 <= $b2);
	$part2++ if $b1 > $a2 or $a1 > $b2;
}

say "part 1: $part1";
say "part 2: ", $. - $part2;
