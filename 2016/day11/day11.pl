#!/usr/bin/perl
use v5.18;
use warnings;

sub elevate(@) {
	my ($moves, $items);

	pop @_;
	for (@_) {
		$items += $_;
		$moves += 2 * ($items - 1) - 1;
	}

	return $moves;
}

my @items = map { scalar( () = /generator|microchip/g ) } <>;

say 'part 1: ', elevate(@items);
$items[0] += 4;
say 'part 2: ', elevate(@items);
