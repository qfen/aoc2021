#!/usr/bin/perl
use v5.18;
use warnings;

my %part1;
my ($hx, $hy, $tx, $ty) = (0, 0, 0, 0);
my %dirs = (L => [-1, 0], R => [ 1, 0], U => [ 0, 1], D => [ 0,-1]);
my ($diffx, $diffy);

while (<>) {
	/^([LRUD]) (\d+)$/ or die 'weird line';

	for (1 .. $2) {
		$hx += $dirs{$1}->[0];
		$hy += $dirs{$1}->[1];
		$diffx = $hx - $tx;
		$diffy = $hy - $ty;
		if (abs($diffx) == 2 or abs($diffy) == 2) {
			$tx += ($diffx <=> 0);
			$ty += ($diffy <=> 0);
		}

		$part1{"$tx,$ty"} = undef;
		#say "$1 h($hx,$hy) t($tx,$ty)";
	}
}

say 'part 1: ', scalar keys %part1;
