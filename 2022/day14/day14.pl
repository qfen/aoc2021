#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'first';

my $ymax = 0;
my @input;

while (<>) {
	my @line;
	for (split / -> /) {
		/^(\d+),(\d+)$/ or die 'weird coordinate';
		my ($x, $y) = (int($1), int($2));

		$ymax = $y if $y > $ymax;
		push @line, [$x, $y];
	}
	push @input, \@line;
}

my $map = [];
while (@input) {
	my $l = shift @input;
	for my $i (1 .. $#$l) {
		my ($x1, $y1) = @{ $l->[$i - 1] };
		my ($x2, $y2) = @{ $l->[$i] };
		($x1, $x2) = ($x2, $x1) if $x1 > $x2;
		($y1, $y2) = ($y2, $y1) if $y1 > $y2;

		for my $x ($x1 .. $x2) {
			for my $y ($y1 .. $y2) {
				$map->[$y][$x] = '#';
			}
		}
	}
}

my ($part1, $part2);

OUTER: while () {
	my ($x, $y) = (500, 0);

	while () {
		my $newx = first { ! $map->[$y + 1][$_] } $x, $x - 1, $x + 1;
		if ($newx) {
			$x = $newx;
			$y++;
			if ($y >= $ymax + 2) {
				$map->[$y][$x] = 'o';
				$part1 = $part2 unless $part1;
				last;
			}
		} else {
			$map->[$y][$x] = 'o';
			$part2++;
			last OUTER if $y == 0;
			last;
		}
	}
}

say "part 1: $part1";
say "part 2: $part2";
