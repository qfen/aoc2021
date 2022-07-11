#!/usr/bin/perl
use v5.28;
use warnings;
use List::Util qw(max sum0);

my @ingredient;

use constant {
	NAME => 0,
	CAPACITY => 1,
	DURABILITY => 2,
	FLAVOR => 3,
	TEXTURE => 4,
	CALORIES => 5
};

while (<STDIN>) {
	chomp;
	/^([a-z]+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)$/i
		or die 'weird line';

	my @vals = map { int } $2, $3, $4, $5, $6;
	my $cache = [];

	push @ingredient, [ $1, @vals, $cache, sum0 @vals ];
	# simpler to export CSV and optimize with Solver in Excel
	say join ',', $1, @vals;
}
