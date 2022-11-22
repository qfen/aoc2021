#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'product';

my %graph;
my @queue;

while (<>) {
	/^	(?^:(value (\d+)) goes to (bot \d+)) |
		(?: (bot [ ] \d+)
			(?^: gives low to ((?:bot|output) \d+))
			(?^: and high to ((?:bot|output) \d+)) )
	$/x or die 'weird line';

	die 'duplicate' if exists $graph{$1 // $4};

	if (defined $1) {
		$graph{$1} = [ [ $3, int $2 ] ];
		push @queue, $graph{$1};
	} else {
		$graph{$4} = [ [ $5, undef ], [ $6, undef ] ];
	}
}

while (my $ref = shift @queue) {
	if (4 == scalar @$ref) {
		my ($v0, $v1) = splice @$ref, -2;
		($v0, $v1) = ($v1, $v0) if $v1 < $v0;
		$ref->[0][1] = $v0;
		$ref->[1][1] = $v1;
	}

	for (@$ref) {
		my ($to, $val) = @$_;
		die unless defined $val;
		push $graph{$to}->@*, $val;
		push @queue, $graph{$to} if 4 == scalar $graph{$to}->@*;
	}
}

say 'part 1: ', grep { $graph{$_}->[0][1] == 17 and $graph{$_}->[1][1] == 61 } grep { /^bot/ } keys %graph;
say 'part 2: ', product map { $graph{"output $_"}->[0] } 0 .. 2;
