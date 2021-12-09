#!/usr/local/bin/perl
use v5.28;
use warnings;
use List::Util 'reduce';

my @grid = <STDIN>;
chomp @grid;
my ($i, $j, $here, @low);
my $len = length $grid[0];

for $i ( 0 .. $#grid ) {
	for $j ( 0 .. $len - 1 ) {
		$here = substr $grid[$i], $j, 1;
		next if $j > 0 and substr($grid[$i], $j - 1, 1) le $here;
		next if $j < $len - 1 and substr($grid[$i], $j + 1, 1) le $here;
		next if $i > 0 and substr($grid[$i - 1], $j, 1) le $here;
		next if $i < $#grid and substr($grid[$i + 1], $j, 1) le $here;
		push @low, $here;
		say "$i,$j: $here";
	}
}

say "@low";
say 'part 1: ', reduce { $a + $b + 1 } 0, @low;
