#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'any';

my ($part1, $part2);

while (my $line = <>) {
	my ($abba, $baab); # for part 1
	my (%in, %out); # for part 2

	while ($line =~ /(?| ( \[ )? ((?>[a-z]+)) (?(1) \] | ) )/gx) {
		my ($bracket, $buf) = (defined($1), $2);

		while ($buf =~ /([a-z])([a-z])\1/g) {
			if ($1 eq $2) {
				pos($buf) -= 1;
				next;
			} else {
				pos($buf) -= 2;
			}

			if ($bracket) {
				# intentionally reversed
				$in{"$2$1"} = undef;
			} else {
				$out{"$1$2"} = undef;
			}
		}

		if ($buf =~ /
			([a-z])([a-z])	(?# two letters)
			\2\1		(?# reversed like ABBA)
			(?(?{ $1 eq $2 }) (*FAIL) | ) (?# bail unless letters differ )
			/x) {
			if ($bracket) {
				$baab = 1;
			} else {
				$abba = 1;
			}
		}
	}

	$part1 += int( !!$abba && !$baab );
	$part2 += int any { exists $in{$_} } keys %out;
}

say "part 1: $part1";
say "part 2: $part2";
