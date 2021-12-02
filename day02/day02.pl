#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/2
# https://adventofcode.com/2021/day/2/input

use v5.28;
use warnings;

my($forward, $down) = (0, 0);
my($dir, $dist);

while (my $line = <STDIN>) {
	chomp $line;
	$line =~ /^(\w+)\s+(\d+)$/ or warn "unknown input";
	($dir, $dist) = ($1, int $2);

	for ($dir) {
		$forward += $dist if $_ eq 'forward';
		$down += $dist    if $_ eq 'down';
		$down -= $dist    if $_ eq 'up';
	}
}

say $forward * $down;
