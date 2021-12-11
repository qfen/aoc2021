#!/usr/bin/perl

use v5.28;
use warnings;
use Data::Dumper;

sub charge {
	my $grid = shift;
	my $count = 0;
	my (@queue, $flash, $row, $col);

	# phase 1: increment all cells, add new 10s to queue
	for $row (0 .. 9) {
		for $col (0 .. 9) {
			if (++$grid->[$row][$col][0] == 10) {
				push @queue, $grid->[$row][$col];
			}
		}
	}

	# phase 2: as long as there is a cell needing to flash, increment all
	# of its neighbors; add them to the work queue if EXACTLY equal to 10
	while ($flash = shift @queue) {
		$count++;
		for ($flash->[1]->@*) {
			push @queue, $_ if ++$_->[0] == 10;
		}
	}

	# phase 3: reset all spent cells to zero
	for $row (0 .. 9) {
		for $col (0 .. 9) {
			$grid->[$row][$col][0] = 0 if $grid->[$row][$col][0] >= 10;
		}
	}

	return $count;
}

# grid cell: val, [ adjacency list ]
my @grid = map { chomp; [ map { [ $_, [] ] } split // ] } <STDIN>;

# build adjacency list as four bidirectional references between grid cells
for my $row (0 .. 9) {
	for my $col (0 .. 9) {
		for ([0, -1], [-1, -1], [-1, 0], [-1, 1]) {
			my ($tgt_row, $tgt_col) = ($row + $_->[0], $col + $_->[1]);
			next unless 0 <= $tgt_row <= 9 and 0 <= $tgt_col <= 9;
			push $grid[$row][$col][1]->@*, $grid[$tgt_row][$tgt_col];
			push $grid[$tgt_row][$tgt_col][1]->@*, $grid[$row][$col];
		}
	}
}

my ($turn, $count, $total) = (0, 0, 0);
my ($part1, $part2);

while (!($part1 and $part2)) {
	$turn++;
	$count = charge(\@grid);
	$total += $count;

	$part1 = $total if $turn == 100;
	$part2 = $turn if !$part2 and $count == 100;
}

say 'part 1: ', $part1;
say 'part 2: ', $part2;
