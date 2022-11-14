#!/usr/bin/perl
use v5.18;
use warnings;

my $grid = [ map { [ (0) x 50 ] } (1 .. 6) ];

while (<>) {
	m/^	(?:rect [ ] (\d+)x(\d+)) |
		(?:rotate [ ]
			(?:row[ ]y=(\d+) | column[ ]x=(\d+))
			[ ] by [ ](\d+)
		)$/x or die 'weird line';

	if (defined $1) {
		for my $row (0 .. $2 - 1) {
			for my $col (0 .. $1 - 1) {
				$grid->[$row][$col] = 1;
			}
		}
	} else {
		if (defined $3) {
			my $rref = $grid->[$3];
			unshift @$rref, pop @$rref for (1 .. $5);
		} else {
			my @transpose = map { $_->[$4] } @$grid;
			unshift @transpose, pop @transpose for (1 .. $5);
			for (my $i = 0; $i < @$grid; $i++) {
				$grid->[$i][$4] = $transpose[$i];
			}
		}
	}
}

my $part1;
for (@$grid) {
	$part1 += grep { $_ } @$_;
}
say $part1;
for (@$grid) {
	for (my $i = 0; $i < @$_; $i += 5) {
		print map { $_ ? '*' : ' ' } @$_[$i .. $i+4];
		print ' ';
	}
	print "\n";
}
