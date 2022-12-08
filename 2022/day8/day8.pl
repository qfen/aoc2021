#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'max';

# (height, visible, scenic) tuples
my $trees = [ map { chomp; [ map { int } split // ] } <> ];

my $x_end = $#{ $trees->[0] };
my $y_end = $#$trees;
my $part1 = 2 * ($x_end + $y_end);
my $part2 = 0;

for my $row (1 .. $y_end - 1) {
	for my $col (1 .. $x_end - 1) {
		my $height = $trees->[$row][$col];
		my ($scene, $vis) = (1, 0);
		my ($max, $dist);

		# moving left
		($max, $dist) = (0, undef);
		for my $x (reverse 0 .. $col - 1) {
			if (!$dist and $trees->[$row][$x] >= $height) {
				$dist = $col - $x;
			}
			$max = max $max, $trees->[$row][$x];
		}
		$scene *= $dist // $col;
		$vis = 1 if $height > $max;

		# moving right
		($max, $dist) = (0, undef);
		for my $x ($col + 1 .. $x_end) {
			if (!$dist and $trees->[$row][$x] >= $height) {
				$dist = $x - $col;
			}
			$max = max $max, $trees->[$row][$x];
		}
		$scene *= $dist // ($x_end - $col);
		$vis = 1 if $height > $max;

		# moving up
		($max, $dist) = (0, undef);
		for my $y (reverse 0 .. $row - 1) {
			if (!$dist and $trees->[$y][$col] >= $height) {
				$dist = $row - $y;
			}
			$max = max $max, $trees->[$y][$col];
		}
		$scene *= $dist // $row;
		$vis = 1 if $height > $max;

		# moving down
		($max, $dist) = (0, undef);
		for my $y ($row + 1 .. $y_end) {
			if (!$dist and $trees->[$y][$col] >= $height) {
				$dist = $y - $row;
			}
			$max = max $max, $trees->[$y][$col];
		}
		$scene *= $dist // ($y_end - $row);
		$vis = 1 if $height > $max;

		$part1 += $vis;
		$part2 = max $scene, $part2;
	}
}

#say join(' ', map { "(@$_)" } @$_) for @$trees;
say "part 1: $part1";
say "part 2: $part2";
