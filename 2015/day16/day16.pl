#!/usr/bin/perl
use v5.28;
use warnings;

die "Usage: $0 INPUT_FILE DETECT_FILE" unless -f $ARGV[0] and -f $ARGV[1];

my (%sensor, @part1, @part2, $in);

open $in, '<', $ARGV[1] or die;
while (<$in>) {
	/^(\w+): (\d+)$/ or die 'weird line';
	$sensor{$1} = int $2;
}
close $in;

open $in, '<', $ARGV[0] or die;
while (<$in>) {
	/^Sue (\d+): /g or die 'weird line';
	my $num = $1;

	my ($part1_match, $part2_match) = (1, 1);
	while (/\G(\w+): (\d+)(?:, )?/g) {
		$part1_match &= ($sensor{$1} == $2);

		if ($1 eq 'cats' or $1 eq 'trees') {
			$part2_match &= ($sensor{$1} < $2);
		} elsif ($1 eq 'pomeranians' or $1 eq 'goldfish') {
			$part2_match &= ($sensor{$1} > $2);
		} else {
			$part2_match &= $part1_match;
		}
	}

	push @part1, $num if $part1_match;
	push @part2, $num if $part2_match;
}
close $in;

# problem statement says there will only be one of each
say "part 1: @part1";
say "part 2: @part2";
