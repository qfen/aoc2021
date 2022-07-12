#!/usr/bin/perl
use v5.28;
use warnings;
# usage: day17.pl [TOTAL] < input
# optional TOTAL defaults to 150

my @bins = sort { $b <=> $a } map { int } <STDIN>;
my $goal = int($ARGV[0] // 150);
my ($mindepth, $part2) = (~0, 0);

warn "find combinations summing to $goal from (@bins)";
sub recurse {
	# sum: incoming total, next: next index for us to use
	my ($sum, $next, $depth) = @_;
	my $added;
	my $part1 = 0;

	for my $i ($next .. $#bins) {
		$added = $sum + $bins[$i];
		if ($added > $goal) {
			next;
		} elsif ($added == $goal) {
			$part1++;
			if ($depth < $mindepth) {
				$part2 = 0;
				$mindepth = $depth;
			}
			$part2++ if $depth == $mindepth;
			#warn "found one at depth $depth (i=$i)";
		} else {
			$part1 += recurse($added, $i + 1, $depth + 1);
		}
	}

	return $part1;
}

say 'part 1: ', recurse(0, 0, 1);
say 'part 2: ', $part2; # which were found at depth $mindepth
