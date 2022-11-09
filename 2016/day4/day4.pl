#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'reduce';

my $part1;

while (<>) {
	/^([-a-z]+)(\d+)\[([a-z]+)\]$/ or die 'weird line';

	my $letters = reduce { $a->{$b}++, $a }
		+{}, grep { $_ ne '-' } split //, $1;

	my @counts = sort { $b->[0] <=> $a->[0] || $a->[1] cmp $b->[1] }
		map { [ $letters->{$_}, $_ ] }
		keys %$letters;

	$part1 += $2 * ($3 eq join '', map { $_->[1] } @counts[0 .. 4]);
}

say "part 1: $part1";
