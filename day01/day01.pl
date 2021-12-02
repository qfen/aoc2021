#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/1
# https://adventofcode.com/2021/day/1/input
# Usage: day01.pl < FILE

use v5.28;
use warnings;

my $int;
my $prev = ~0; # for part 1
my @windows; # for part 2
my($part1, $part2) = (0, 0);

while (my $line = <STDIN>) {
	chomp $line;
	warn "non-numeric" if $line =~ /[^\d]/;
	$int = int $line;

	# part 1: count number of times this input is larger than previous line
	$part1++ if $int > $prev;
	$prev = $int;

	# part 2: count number of times this 3-line sliding window is greater
	# than the preceding window
	$windows[$_] += $int for (1 .. 3);
	$part2++ if $. > 3 and $windows[1] > $windows[0];
	shift @windows;
}

say "part 1: $part1";
say "part 2: $part2";
