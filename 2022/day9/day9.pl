#!/usr/bin/perl
use v5.18;
use warnings;

my %dirs = (L => [-1, 0], R => [ 1, 0], U => [ 0, 1], D => [ 0,-1]);
my @knots = map { [0, 0] } 1 .. 10;
my (%part1, %part2);

while (<>) {
	/^([LRUD]) (\d+)$/ or die 'weird line';

	for (1 .. $2) {
		$knots[0]->[0] += $dirs{$1}->[0];
		$knots[0]->[1] += $dirs{$1}->[1];

		for my $i (1 .. $#knots) {
			my $diffx = $knots[$i - 1]->[0] - $knots[$i]->[0];
			my $diffy = $knots[$i - 1]->[1] - $knots[$i]->[1];

			if (abs($diffx) == 2 or abs($diffy) == 2) {
				$knots[$i]->[0] += ($diffx <=> 0);
				$knots[$i]->[1] += ($diffy <=> 0);
			}
		}

		$part1{ "@{ $knots[1] }" } = undef;
		$part2{ "@{ $knots[9] }" } = undef;
	}
}

say 'part 1: ', scalar keys %part1;
say 'part 2: ', scalar keys %part2;
