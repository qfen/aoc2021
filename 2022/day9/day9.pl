#!/usr/bin/perl
use v5.18;
use warnings;

my %dirs = (L => [-1, 0], R => [ 1, 0], U => [ 0, 1], D => [ 0,-1]);
my @knots = (0) x 20;
my (%part1, %part2);

while (<>) {
	/^([LRUD]) (\d+)$/ or die 'weird line';

	for (1 .. $2) {
		$knots[0] += $dirs{$1}->[0];
		$knots[1] += $dirs{$1}->[1];

		for (my $i = 2; $i < 20; $i += 2) {
			my $diffx = $knots[$i - 2] - $knots[$i];
			my $diffy = $knots[$i - 1] - $knots[$i + 1];

			if (abs($diffx) == 2 or abs($diffy) == 2) {
				$knots[  $i  ] += ($diffx <=> 0);
				$knots[$i + 1] += ($diffy <=> 0);
			}
		}

		$part1{"@knots[2,3]"} = undef;
		$part2{"@knots[18,19]"} = undef;
	}
}

say 'part 1: ', scalar keys %part1;
say 'part 2: ', scalar keys %part2;
