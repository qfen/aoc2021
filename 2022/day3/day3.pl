#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'first';

my ($group, $part1, $part2);

sub prio { (ord $_[0]) - ((ord $_[0]) & 0x20 ? 96 : 38) }

while (<>) {
	chomp;
	my %ruck;
	my $half = length($_) / 2;

	@ruck{ split //, substr($_, 0, $half) } = ();

	$part1 += prio( first { exists $ruck{$_} } split //, substr($_, $half) );

	@ruck{ split //, substr($_, $half) } = ();

	if ($. % 3 == 1) {
		$group = \%ruck;
	} else {
		# set intersection
		delete $group->{$_} for grep { ! exists $ruck{$_} } keys %$group;

		$part2 += prio((keys %$group)[0]) if ($. % 3 == 0);
	}
}

say "part 1: $part1";
say "part 2: $part2";
