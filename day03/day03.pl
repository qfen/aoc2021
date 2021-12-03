#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/3
# https://adventofcode.com/2021/day/3/input
# Usage: ./day03.pl < FILE

use v5.28;
use warnings;
use List::Util 'reduce';

my(@sums, @elements, $line, $i);

while ($line = <STDIN>) {
	chomp $line;
	warn "non-binary input" if $line =~ /[^01]/;
	
	@elements = split //, $line;
	for ($i = 0; $i < @elements; $i++) {
		$sums[$i] += $elements[$i];
	}
}

my $gamma = reduce { ($a << 1) | ($b > ($. / 2)) } 0, @sums;
my $epsilon = ~$gamma & (2 ** @sums - 1);
say $gamma * $epsilon;
