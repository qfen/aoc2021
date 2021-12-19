#!/usr/bin/perl
use v5.28;
use warnings;

my @lines;
my @rots;
while (<STDIN>) {
	chomp;
	next unless /(-?\d)\s+(-?\d)\s+(-?\d)/;
	push @lines, [ map { int } $1, $2, $3 ];
}
push @rots, [ splice @lines, 0, 3 ] while @lines;

say "\@rots = (";
say join ",\n", map { "\t[ " . join(", ", map { sprintf '[%2d,%2d,%2d]', @$_ } @$_) . " ]" } @rots;
say ");";
