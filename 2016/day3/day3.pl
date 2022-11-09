#!/usr/bin/perl
use v5.18;
use warnings;

sub triangle {
	my ($sum, $max);

	for (@_) {
		no warnings 'uninitialized';
		$sum += $_;
		$max = $_ if $_ > $max;
	}

	return $max < ($sum - $max);
}

my ($part1, $part2, @cols);

while (<>) {
	my @nums = map { int } $_ =~ /\d+/g;
	$part1++ if triangle(@nums);

	for (0 .. 2) {
		push $cols[$_]->@*, $nums[$_];
		next if $. % 3;

		$part2 += triangle($cols[$_]->@*);
		$#{ $cols[$_] } =  -1;
	}
}

say "part 1: $part1";
say "part 2: $part2";
