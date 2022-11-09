#!/usr/bin/perl
use v5.18;
use warnings;

my @freqs;
my ($part1, $part2);

while (<>) {
	chomp;
	my $i = 0;
	$freqs[$i++]->{$_}++ for split //;
}

for (@freqs) {
	my ($min, $max);

	for my $k (keys %$_) {
		no warnings 'uninitialized';
		$max = $k if $_->{$k} > $_->{$max};
		$min = $k if $_->{$k} < ($_->{$min} // ~1);
	}

	$part1 .= $max;
	$part2 .= $min;
}

say "part 1: $part1";
say "part 2: $part2";
