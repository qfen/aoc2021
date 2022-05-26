#!/usr/bin/perl
use v5.28;
use warnings;

my $next;
my $in = <STDIN>;
chomp $in;

for (1 .. 50) {
	$next = '';
	while ($in =~ /\G(\d)(\1*)/g) {
		$next .= length($&) . $1;
	}
	$in = $next;
	say 'part 1: ', length $in if $_ == 40;
}

say 'part 2: ', length $in;
