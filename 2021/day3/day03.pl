#!/usr/bin/perl
# https://adventofcode.com/2021/day/3
# https://adventofcode.com/2021/day/3/input
# Usage: ./day03.pl < FILE

use v5.28;
use warnings;
use List::Util 'reduce';

my @lines = <STDIN>; # TODO: input validation
chomp @lines;

sub count {
	my @bits = split //, $_[1];
	for (0 .. $#bits) {
		$_[0]->[$_] += $bits[$_];
	}
	return $_[0];
}

my $sums = reduce { count($a, $b) } ([], @lines);

my $gamma = oct '0b' . join('', map {$_ > $. / 2 ? 1 : 0} @$sums);
my $epsilon = ~$gamma & (2 ** @$sums - 1);
say "part 1: ", $gamma * $epsilon;

# part 2

# filter_bits(current, sum, width, invert)
# current: arrayref with initial state of list to filter
# sum: total number of 1 bits in the first column of $current
# width: number of bits in a row
# invert: 0 to select most common bits, 1 to select least common
sub filter_bits {
	my($current, $sum, $width, $invert) = @_;
	my($prev, $bit, $next_sum);

	for (my $i = 0; @$current > 1; $i++) {
		die "filter went wrong" if $i > $width;
		$prev = $current;
		$current = [];
		$next_sum = 0;
		$bit = $invert ^ (($sum >= @$prev / 2) ? 1 : 0);

		for (@$prev) {
			if (substr($_, $i, 1) eq $bit) {
				push @$current, $_;
				$next_sum += substr($_, $i + 1, 1) if $i < $width - 1;
			}
		}
		$sum = $next_sum;
	}

	return oct '0b' . $current->[0];
}

my $oxy = filter_bits(\@lines, $sums->[0], scalar @$sums, 0);
my $co2 = filter_bits(\@lines, $sums->[0], scalar @$sums, 1);
say "part 2: ", $oxy * $co2;
