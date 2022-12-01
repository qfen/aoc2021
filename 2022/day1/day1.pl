#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util qw(reduce sum);

$/ = '';

# eliminate temporary list
#my @elves = sort { $b <=> $a } map { reduce { $a + $b } split /\s+/ } <>;

# explicit numeric conversion
#my @elves = sort { $b <=> $a } map { sum map { int } split /\s+/ } <>;

# concise
my @elves = sort { $b <=> $a } map { sum split /\s+/ } <>;

say "part 1: ", $elves[0];
say "part 2: ", sum @elves[0 .. 2];
