#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/2
# https://adventofcode.com/2021/day/2/input

use v5.28;
use warnings;
no warnings 'experimental::smartmatch';

my($forward, $part1_depth, $part2_depth) = (0, 0, 0);
my($dir, $dist);

while (my $line = <STDIN>) {
	chomp $line;
	$line =~ /^(\w+)\s+(\d+)$/ or warn "unknown input";
	($dir, $dist) = ($1, int $2);

	for ($dir) {
		when ('forward') {
			$forward += $dist;
			$part2_depth += $dist * $part1_depth;
		}

		$part1_depth += $dist when 'down';
		$part1_depth -= $dist when 'up';

		default { warn "unknown direction '$dir'"; }
	}
}

say 'part 1: ', $forward * $part1_depth;
say 'part 2: ', $forward * $part2_depth;
