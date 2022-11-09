#!/usr/bin/perl
use v5.18;
use warnings;

my ($x, $y, $d) = (0, 0, 0);
my $t = [
	[0, 1],
	[1, 0],
	[0, -1],
	[-1, 0]
];

my %cache;
my $part2;

for (split /,\s+/, <>) {
	/^(?:L|(R))(\d+)$/ or die 'weird line';
	$d = ($d + 2 * defined($1) - 1) % 4;
	my $count = 0;
	my ($xstep, $ystep) = $t->[$d]->@*;

	while ($count++ < $2) {
		$x += $xstep;
		$y += $ystep;
		next if $part2;

		my $loc = "$x,$y";
		if (exists $cache{$loc}) {
			$part2 = abs($x) + abs($y);
		} else {
			$cache{$loc} = undef;
		}
	}
}

say 'part 1: ', abs($x) + abs($y);
say 'part 2: ', $part2;
