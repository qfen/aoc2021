#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'reduce';

my ($part1, $part2);

while (<>) {
	/^([-a-z]+)(\d+)\[([a-z]+)\]$/ or die 'weird line';

	my $sector = int $2;
	my (%freq, $decode);

	for (split //, $1) {
		if ($_ eq '-') {
			$decode .= ' ';
		} else {
			$freq{$_}++;
			$decode .= chr( ((-97 + ord $_) + $sector) % 26 + 97 );
		}
	}

	my @counts = sort { $b->[0] <=> $a->[0] || $a->[1] cmp $b->[1] }
		map { [ $freq{$_}, $_ ] }
		keys %freq;

	$part1 += $sector * ($3 eq join '', map { $_->[1] } @counts[0 .. 4]);
	$part2 = $sector if $decode =~ /northpole/;
}

say "part 1: $part1";
say "part 2: $part2";
