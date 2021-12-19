#!/usr/bin/perl

use v5.28;
use warnings;
use List::Util 'first';

sub str_intersect { grep { index($_[0], $_) >= 0 } (split //, $_[1]) }
sub str_sort { join('', sort split(//, $_[0])) }

sub decode {
	my %result;
	my (@sort, @working, @five, @six, $index);
	@sort = map { str_sort($_) } sort {length($a) <=> length($b)} split(/ /, $_[0]);

	@working[1, 7, 4, 8] = @sort[0, 1, 2, 9]; # using two, three, four and seven segments
	@five = @sort[3 .. 5];# 2 3 5 (five segments)
	@six = @sort[6 .. 8]; # 0 6 9 (six segments)

	# pull 3 out of the five-segment list
	$index = first { str_intersect($working[1], $five[$_]) == 2 } 0 .. 2;
	$working[3] = splice @five, $index, 1;

	# pull 9 out of the six-segment list
	$index = first { str_intersect($working[4], $six[$_]) == 4 } 0 .. 2;
	$working[9] = splice @six, $index, 1;

	# compare 4 against 2/5
	@working[2, 5] = str_intersect($working[4], $five[0]) == 2 ? @five : reverse @five;

	# compare 0 against 1
	@working[0, 6] = str_intersect($working[1], $six[0]) == 2 ? @six : reverse @six;

	%result = map { $working[$_] => $_ } 0 .. 9;
	return \%result;
}

my ($part1, $part2, @part1_lookup);
my ($total, $group, $digit, $key, $in, $out);
@part1_lookup[1, 4, 7,8] = (1, 1, 1, 1);

while (<STDIN>) {
	chomp;
	($in, $out) = split / \| /;
	$key = decode($in);
	$total = 0;

	for $group (split / /, $out) {
		$digit = $key->{str_sort($group)};
		$total = $total * 10 + $digit;

		# part 1 made easier by doing part 2 first
		$part1++ if $part1_lookup[$digit];
	}
	$part2 += $total;
}

say 'part 1: ', $part1;
say 'part 2: ', $part2;
