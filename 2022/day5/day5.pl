#!/usr/bin/perl
use v5.18;
use warnings;

my ($part1, $part2) = ([], []);

while (<>) {
	last if /^\s+1/;

	for (my $i = 0; $i < length($_) / 4; $i++) {
		my $c = substr $_, 4 * $i + 1, 1;
		next if $c eq ' ';
		unshift @{ $part1->[$i] }, $c;
		unshift @{ $part2->[$i] }, $c;
	}
}

while (<>) {
	next unless /^move (\d+) from (\d+) to (\d+)/;

	push @{ $part1->[$3 - 1] }, reverse (splice @{ $part1->[$2 - 1] }, -$1);
	push @{ $part2->[$3 - 1] }, (splice @{ $part2->[$2 - 1] }, -$1);
}

say 'part 1: ', map { $_->[-1] } @$part1;
say 'part 2: ', map { $_->[-1] } @$part2;
