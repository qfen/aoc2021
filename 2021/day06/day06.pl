#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/6
# https://adventofcode.com/2021/day/6/input

use v5.28;
use warnings;

my(@state, $sum, $spawn);
my $days = int $ARGV[0] or die "Usage: $0 DAYS < FILE";

$/ = ',';
while (<STDIN>) {
	chomp;
	$state[int $_]++;
}
$sum = $.;

for (1 .. $days) {
	$sum += $spawn = shift(@state) // 0;
	$state[6] += $state[8] = $spawn;
}

say "lanternfish after $days days: $sum";
