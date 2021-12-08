#!/usr/local/bin/perl

use v5.28;
use warnings;
use List::Util 'any';

my %uniq;
@uniq{2,3,4,7} = ();
my($count, $in, $out);

while (<STDIN>) {
	chomp;
	($in, $out) = split / \| /;
	$count += grep { exists $uniq{length $_} } split(/ /, $out);
}

say 'part 1: ', $count;
