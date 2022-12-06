#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'uniqstr';

my ($part1, $part2);
chomp(my $line = <>);

for (my $i = 3; $i < length($line); $i++) {
	$part1 = $i + 1 if !$part1 and 4 == uniqstr split //, substr($line, $i - 3, 4);

	if ($i >= 13 and 14 == uniqstr split //, substr($line, $i - 13, 14)) {
		$part2 = $i + 1;
		last;
	}
}

say "part 1: $part1";
say "part 2: $part2";
