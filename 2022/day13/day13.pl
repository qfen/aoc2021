#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'product';

sub cmp13 {
	my ($l, $r) = @_;
	my $val;

	for my $i (0 .. $#$l) {
		return 1 if $i > $#$r;

		my ($lref, $rref) = map { 'ARRAY' eq ref $_->[$i] } $l, $r;
		if ($lref and $rref) {
			$val = cmp13($l->[$i], $r->[$i]);
		} elsif ($lref) {
			$val = cmp13($l->[$i], [ $r->[$i] ]);
		} elsif ($rref) {
			$val = cmp13([ $l->[$i] ], $r->[$i]);
		} else {
			#say "chunk $.: $l->[$i] <=> $r->[$i]";
			$val = $l->[$i] <=> $r->[$i];
		}

		return $val unless $val == 0;
	}

	return $#$l <=> $#$r;
}

my @input;
my ($part1, $part2);
$/ = '';

while (<>) {
	die 'weird line' if /[^[],\d\s]/;
	my ($p1, $p2) = map { eval } split /\n/;

	$part1 += $. if -1 == cmp13($p1, $p2);
	push @input, $p1, $p2;
}

my ($d1, $d2) = ( [[2]], [[6]] );

@input = sort { cmp13($a, $b) } @input, $d1, $d2;
$part2 = product grep { $input[$_-1] == $d1 or $input[$_-1] == $d2 } 1 .. @input;

say "part 1: $part1";
say "part 2: $part2";
