#!/usr/bin/perl
use v5.28;
use warnings;
use List::Util 'uniqstr';

my $in = <STDIN>;
chomp $in;

sub advance {
	my $in = shift;
	while (++$in) {
		# check 2
		if ($in =~ /([iol])/g) {
			substr($in, pos($in) - 1) = $1 . 'z' x (8 - pos $in);
			#warn "fail check 2";
			next;
		}

		# check 3
		if (uniqstr( $in =~ /([a-z])(?=\1)/g ) < 2) {
			#warn "fail check 3";
			next;
		}

		# check 1
		for (0 .. 5) {
			my ($a, $b, $c) = map { ord } split(//, substr $in, $_, 3);
			if (($a + 1 == $b) and ($b + 1 == $c)) {
				return $in;
			}
			#warn "fail check 1";
		}
	}
}

say 'part 1: ', $in = advance($in);
say 'part 2: ', $in = advance($in);
