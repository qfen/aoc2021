#!/usr/bin/perl
use v5.28;
use warnings;

my ($text, @sub);

while (<STDIN>) {
	chomp;
	if (/^(\w+) => (\w+)$/) {
		push @sub, [$1, $2];
	} else {
		$text = $_;
	}
}

my %part1;

for (@sub) {
	my ($find, $replace) = @$_;
	while ($text =~ /$find/g) {
		pos($text) -= length $find;
		$part1{ $text =~ s/\G$find/$replace/r } = undef;
		pos($text) += length $find;
	}
}

say 'part 1: ', scalar keys %part1;
