#!/usr/bin/perl
use v5.18;

my ($part1, $part2);

while (<>) {
	my ($min, $max, $pt2_done, @line) = (~0, 0);

	OUTER: for my $num ( map { int } split /\s+/ ) {
		$min = $num if $num < $min;
		$max = $num if $num > $max;

		next if $pt2_done;

		for (@line) {
			my $frac = ($_ < $num) ? $num / $_ : $_ / $num;

			if ($frac == int $frac) {
				$part2 += $frac;
				$pt2_done = 1;
				next OUTER;
			}
		}

		push @line, $num;
	}

	$part1 += $max - $min;
}

say "part 1: $part1";
say "part 2: $part2";
