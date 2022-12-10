#!/usr/bin/perl
use v5.18;
use warnings;

my ($cycle, $x, $check) = (0, 1, 20);
my $part1;
my $part2 = '.' x 240;

while (<>) {
	/^noop|addx (-?\d+)$/ or die 'weird line';

	for (0 .. defined $1) {
		substr($part2, $cycle, 1, '#') if abs($cycle % 40 - $x) <= 1;
		$cycle++;
	}

	if ($cycle >= $check) {
		$part1 += $check * $x;
		$check += 40;
	}

	$x += $1 // 0;
}

say "part 1: $part1";
for my $i (0 .. 5) {
	say substr $part2, $i * 40, 40;
}
