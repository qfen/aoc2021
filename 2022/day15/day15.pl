#!/usr/bin/perl
use v5.18;
use warnings;

my (@sensors, $part1, %b);
sub taxi { abs($_[2] - $_[0]) + abs($_[3] - $_[1]) }

while (<>) {
	/^Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)$/ or die 'weird line';
	my ($x, $y, $bx, $by) = map { int } $1, $2, $3, $4;
	push @sensors, [$x, $y, taxi($x, $y, $bx, $by)];
	$b{"$bx,$by"} = undef;
}

OUTER: for my $x (-2_000_000 .. 6_000_000) {
	next if exists $b{"$x,2000000"};
	for my $s (@sensors) {
		if (taxi($x, 2_000_000, $s->[0], $s->[1]) <= $s->[2]) {
			$part1++;
			next OUTER;
		}
	}
}

say "part 1: $part1";
