#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'max';

# (height, visible, scenic) tuples
my $trees = [ map { chomp; [ map { [ int, 0, 0 ] } split // ] } <> ];

$_->[1] = 1 for $trees->[0]->@*, $trees->[-1]->@*;
$_->[0][1] = 1, $_->[-1][1] = 1 for @$trees;

my $x_end = $#{ $trees->[0] };
my $y_end = $#$trees;
my $part1 = 2 * ($x_end + $y_end);
my $part2 = 0;

for my $row (1 .. $y_end - 1) {
	for my $col (1 .. $x_end - 1) {
		my $scene = 1;
		my $height = $trees->[$row][$col][0];
		my ($max, $dist);

		# moving left
		($max, $dist) = (0, undef);
		for my $x (reverse 0 .. $col - 1) {
			if (!$dist and $trees->[$row][$x][0] >= $height) {
				$dist = $col - $x;
			}
			$max = max $max, $trees->[$row][$x][0];
		}
		$scene *= $dist // $col;
		$trees->[$row][$col][1] = 1 if $height > $max;

		# moving right
		($max, $dist) = (0, undef);
		for my $x ($col + 1 .. $x_end) {
			if (!$dist and $trees->[$row][$x][0] >= $height) {
				$dist = $x - $col;
			}
			$max = max $max, $trees->[$row][$x][0];
		}
		$scene *= $dist // ($x_end - $col);
		$trees->[$row][$col][1] = 1 if $height > $max;

		# moving up
		($max, $dist) = (0, undef);
		for my $y (reverse 0 .. $row - 1) {
			if (!$dist and $trees->[$y][$col][0] >= $height) {
				$dist = $row - $y;
			}
			$max = max $max, $trees->[$y][$col][0];
		}
		$scene *= $dist // $row;
		$trees->[$row][$col][1] = 1 if $height > $max;

		# moving down
		($max, $dist) = (0, undef);
		for my $y ($row + 1 .. $y_end) {
			if (!$dist and $trees->[$y][$col][0] >= $height) {
				$dist = $y - $row;
			}
			$max = max $max, $trees->[$y][$col][0];
		}
		$scene *= $dist // ($y_end - $row);
		$trees->[$row][$col][1] = 1 if $height > $max;
		$trees->[$row][$col][2] = $scene;
		$part1 += $trees->[$row][$col][1];
		$part2 = $scene if $scene > $part2;
	}
}

#say join(' ', map { "(@$_)" } @$_) for @$trees;
say "part 1: $part1";
say "part 2: $part2";
