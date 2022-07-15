#!/usr/bin/perl
use v5.28;
use warnings;
use List::Util 'sum0';
use POSIX 'ceil';

my $target = int <STDIN>;

my ($max, $part1_target) = (0, $target / 10);
my $part1;
my @factor = (undef, undef);
for (2 .. 900000) {
	for (my $i = $_; $i <= 900000; $i += $_) {
		push $factor[$i]->[0]->@*, $_;
	}
	my $sum = $factor[$_]->[1] = 1 + sum0 $factor[$_]->[0]->@*;

	if ($sum > $max) {
		($max, $part1) = ($sum, $_);
		#say "new best at $part1";
		last if $max >= $part1_target;
	}
}

say 'part 1: ', $part1;

my $part2_target = ceil $target / 11;
say $part2_target;
