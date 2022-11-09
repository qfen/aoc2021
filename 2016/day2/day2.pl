#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util qw(max min);

my ($row, $col) = (1, 1);
my %mv_part1 = (
	R => [ 0, 1, 0],
	L => [ 0,-1, 2],
	U => [-1, 0, 1],
	D => [ 1, 0, 3]
);
my $part1 = '';

my $mv_part2 = [
	undef,
	[1, 1, 1, 3], # 1
	[3, 2, 2, 6],
	[4, 1, 2, 7],
	[4, 4, 3, 8],
	[6, 5, 5, 5], # 5
	[7, 2, 5, 0xA],
	[8, 3, 6, 0xB],
	[9, 4, 7, 0xC],
	[9, 9, 8, 9],
	[0xB, 6, 0xA, 0xA], # A
	[0xC, 7, 0xA, 0xD],
	[0xC, 8, 0xB, 0xC],
	[0xD, 0xB, 0xD, 0xD]
];
my $part2 = '';
my $track_part2 = 5;

while (<>) {
	chomp;
	for (split //) {
		my ($rowmove, $colmove, $part2_index) = $mv_part1{$_}->@*;
		$row = max min($rowmove + $row, 2), 0;
		$col = max min($colmove + $col, 2), 0;

		$track_part2 = $mv_part2->[$track_part2][$part2_index]
			or die 'got lost';
	}

	$part1 .= ( $row * 3 + $col + 1 );
	$part2 .= sprintf '%X', $track_part2;
}

say "part 1: $part1";
say "part 2: $part2";
