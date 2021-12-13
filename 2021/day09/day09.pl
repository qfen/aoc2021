#!/usr/bin/perl
use v5.28;
use warnings;
use List::Util qw(product reduce);

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
	}
}

say 'part 1: ', reduce { $a + $b + 1 } 0, @low;

# flood fill: https://en.wikipedia.org/wiki/Flood_fill#Span_Filling
my @basins;
sub ok {
	my($grid, $x, $y) = @_;
	my $width = length $grid->[0];
	return ((0 <= $x < length $grid->[0]) &&
		(0 <= $y < @$grid) &&
		('0' le substr($grid->[$y], $x, 1) lt '9'));
}

sub scan {
	my($grid, $lx, $rx, $y, $s) = @_;
	my $added;

	for my $x ($lx .. $rx) {
		if (!ok($grid, $x, $y)) {
			$added = undef;
		} elsif (!$added) {
			push @$s, [$x, $y];
			$added = 1;
		}
	}
}

sub fill {
	my($grid, $xstart, $ystart) = @_;
	my($x, $lx, $y, @s, $size);

	ok($grid, $xstart, $ystart) or return 0;
	@s = ([$xstart, $ystart]);

	while (@s) {
		($x, $y) = @{ pop @s };
		$lx = $x;
		while (ok($grid, $lx-1, $y)) {
			substr $grid->[$y], $lx-1, 1, '9';
			$lx--;
			$size++;
		}
		while (ok($grid, $x, $y)) {
			substr $grid->[$y], $x, 1, '9';
			$x++;
			$size++;
		}

		scan($grid, $lx, $x-1, $y+1, \@s);
		scan($grid, $lx, $x-1, $y-1, \@s);
	}

	return $size;
}

while (@grid) {
	if ($grid[0] =~ /[0-8]/g) {
		push @basins, fill(\@grid, pos($grid[0]) - 1, 0);
	} else {
		shift @grid;
	}
}

say 'part 2: ', product ((sort{$b <=> $a} @basins)[0 .. 2]);
