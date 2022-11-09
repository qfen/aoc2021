#!/usr/bin/perl
use v5.18;
use warnings;

my @freqs;

while (<>) {
	chomp;
	my $i = 0;
	$freqs[$i++]->{$_}++ for split //;
}

for (@freqs) {
	for my $k (sort {$_->{$b} <=> $_->{$a}} keys %$_) {
		say "$k: ", $_->{$k};
	}
	say "next";
}
