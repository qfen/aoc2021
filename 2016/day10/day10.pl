#!/usr/bin/perl
use v5.18;
use warnings;

# entry = [ id, val_lo, val_hi, from_lo, from_hi, to_lo, to_hi ]
use constant {
	ID => 0,
	VAL => 1,
	FROM => 2,
	TO => 3,
};
my $bots = [];

while (<>) {
	chomp;
	/^	(?^:value (\d+) goes to bot (\d+)) |
		(?: bot [ ] (\d+)
			(?^: gives low to (bot|output) (\d+))
			(?^: and high to (bot|output) (\d+)) )
	$/x or die 'weird line';

	if (defined $1) {
		push @{ $bots->[$2][VAL] }, int($1);
	} else {
		push @{ $bots->[$3][TO] }, int($4), int($5);
		die if 2 < scalar @{ $bots->[$3][TO] };
	}
}
