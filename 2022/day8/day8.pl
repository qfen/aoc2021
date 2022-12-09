#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'max';

my @moves = ([0, -1], [0, 1], [-1, 0], [1, 0]);
my $trees = [ map { chomp; [ map { int } split // ] } <> ];

my $x_end = $#{ $trees->[0] };
my $y_end = $#$trees;
my $part1 = 2 * ($x_end + $y_end);
my $part2 = 0;

for my $row (1 .. $y_end - 1) {
	for my $col (1 .. $x_end - 1) {
		my ($scene, $vis) = (1, 0);

		for my $dir (@moves) {
			my ($x, $y, $max) = ($col, $row, 0);
			my ($dist, $step);

			while () {
				$x += $dir->[1];
				$y += $dir->[0];

				last unless 0 <= $x <= $x_end and 0 <= $y <= $y_end;

				$step++;
				$max = max $max, $trees->[$y][$x];

				if (!$dist and $trees->[$y][$x] >= $trees->[$row][$col]) {
					$dist = $step;
				}
			}

			$vis = 1 if $trees->[$row][$col] > $max;
			$scene *= $dist // $step;
		}

		$part1 += $vis;
		$part2 = max $scene, $part2;
	}
}

say "part 1: $part1";
say "part 2: $part2";
