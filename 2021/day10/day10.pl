#!/usr/bin/perl

use v5.28;
use warnings;

sub pushdown {
	my $line = shift;
	my @s = ();

	for (my $i = 0; $i < length $line; $i++) {
		for (substr $line, $i, 1) {
			no warnings 'experimental::smartmatch';
			push @s, $_ when $_ =~ /[([{<]/;

			'(' eq pop @s or return (3, undef)	when ')';
			'[' eq pop @s or return (57, undef)	when ']';
			'{' eq pop @s or return (1197, undef)	when '}';
			'<' eq pop @s or return (25137, undef)	when '>';

			default { die "unexpected character $_" }
		}
	}

	return (0, \@s);
}

my ($part1, $error, $stack, @part2_scores, $accum, $delim);
my %lookup = ('(' => 1,
	'[' => 2,
	'{' => 3,
	'<' => 4);

while (<STDIN>) {
	chomp;
	($error, $stack) = pushdown($_);
	$part1 += $error;

	next unless $stack;
	$accum = 0;
	$accum = 5 * $accum + $lookup{$delim} while $delim = pop @$stack;
	push @part2_scores, $accum;
}

say 'part 1: ', $part1;
say 'part 2: ', (sort {$a <=> $b} @part2_scores)[$#part2_scores / 2];
