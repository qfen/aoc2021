#!/usr/bin/perl
use v5.18;
use warnings;

sub adj($$$) {
	my ($ref, $x, $y) = @_;
	my $result = 0;

	for my $i (-1 .. 1) {
		for my $j (-1 .. 1) {
			no warnings 'uninitialized';
			$result += $ref->[$y + $i][$x + $j];
		}
	}

	return $result;
}

my $sq = [];
my $r = 6;

$sq->[$r][$r] = 1;

my ($i, $j, $q) = (1, 0, 0);
my ($x, $y, $entry);

my $input = int <>;

while () {
	$x = $r + $i;
	$y = $r - $j;

	$entry = adj($sq, $x, $y);
	$sq->[$y][$x] = $entry;
	warn $entry, "\n";
	last if $entry > $input;

	if ($q == 0) {
		$j++;
		$q++ if $j == $i;
	} elsif ($q == 1) {
		$i--;
		$q++ if $i == -$j;
	} elsif ($q == 2) {
		$j--;
		$q++ if $j == $i;
	} else {
		$i++;
		$q = 0 if $i > -$j;
		last if $i > $r - 1;
	}
}


say join ' ', map { sprintf "%7u", ($_//0) } @$_ for (@$sq);

say "part 2: $entry";
