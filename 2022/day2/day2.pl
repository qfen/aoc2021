#!/usr/bin/perl
use v5.18;
use warnings;

my ($opp, $own, $part1, $part2);

while (<>) {
	die 'weird line' unless /([ABC]) ([XYZ])/;

	$opp = -65 + ord $1; # 0-rock 1-paper 2-scissors
	$own = -87 + ord $2; # 1-rock 2-paper 3-scissors

	# 		(points for my move)	+ (points for round result)
	$part1 += ($own)			+ (3 * (($own - $opp) % 3));
	$part2 += (($opp + $own - 2) % 3 + 1)	+ (3 * ($own - 1));
}

say "part 1: $part1";
say "part 2: $part2";
