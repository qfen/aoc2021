#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/7
# https://adventofcode.com/2021/day/7/input

use v5.28;
use warnings;
use List::Util qw(max reduce sum);
use POSIX 'lround';

sub p1cost { return abs($_[0] - $_[1]); }
sub p2cost {
	my $dist = abs($_[0] - $_[1]);
	return ($dist * $dist + $dist) >> 1;
}

my(@input, %count, $avg, $median, $cost, $loc);
$/ = ',';
@input = sort {$a <=> $b} map {chomp; int;} <STDIN>;
$count{$_}++ for (@input);
$avg = lround((sum @input) / @input);
$median = $input[scalar(@input) >> 1];

sub p1sort { p1cost($a, $median) <=> p1cost($b, $median) }
sub p2sort { p2cost($a, $avg) <=> p2cost($b, $avg) }

# part 1: fuel cost equals distance; optimal solution will be at the median
# crab location
my $part1_cost = ~0;
for $loc (sort p1sort 0 .. max(keys %count)) {
	$cost = reduce {$a + p1cost($loc, $b) * $count{$b}} 0, keys %count;
	last if $cost > $part1_cost;
	$part1_cost = $cost;
}
say 'part 1: ', $part1_cost;

# part 2: fuel quadratic with distance, (n^2+n)/2; optimal solution will be
# near the average crab location
my $part2_cost = ~0;
for $loc (sort p2sort 0 .. max(keys %count)) {
	$cost = reduce {$a + p2cost($loc, $b) * $count{$b}} 0, keys %count;
	last if $cost > $part2_cost;
	$part2_cost = $cost;
}
say 'part 2: ', $part2_cost;
