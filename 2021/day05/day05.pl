#!/usr/bin/perl
# https://adventofcode.com/2021/day/5
# https://adventofcode.com/2021/day/5/input
# Usage: day05.pl < FILE

use v5.28;
use warnings;
use List::Util qw(max reduce);

my (@map_part1, @map_part2, $line);
my ($x1, $y1, $x2, $y2);
my $diag; # boolean for part 2
my ($xdir, $ydir, $xdist, $ydist, $x, $y);

sub sign { $_[0] < 0 ? -1 : ($_[0] == 0 ? 0 : 1); }

while ($line = <STDIN>) {
	chomp $line;
	$line =~ /^(\d+),(\d+) -> (\d+),(\d+)$/ or warn 'unusual line';
	($x1, $y1, $x2, $y2) = map { int } ($1, $2, $3, $4);

	$xdist = abs($x2 - $x1);
	$ydist = abs($y2 - $y1);
	$xdir = sign($x2 - $x1);
	$ydir = sign($y2 - $y1);
	$diag = $xdir && $ydir;
	die "not snapped to 45 degrees" if $diag and !($xdist == $ydist);

	for my $i (0 .. max($xdist, $ydist)) {
		$x = $x1 + $i * $xdir;
		$y = $y1 + $i * $ydir;
		$map_part2[$x][$y]++;
		$map_part1[$x][$y]++ unless $diag;
	}
}

say 'part 1: ', reduce { $a + grep {($_ // 0) > 1} @$b } 0, @map_part1;
say 'part 2: ', reduce { $a + grep {($_ // 0) > 1} @$b } 0, @map_part2;
