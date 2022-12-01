#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'sum';

$/ = '';

my @elves = sort { $b <=> $a } map { sum map { int } split /\s+/ } <>;

say "part 1: ", $elves[0];
say "part 2: ", sum @elves[0 .. 2];
