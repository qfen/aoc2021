#!/usr/bin/perl
use v5.34;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
use Math::BigInt;

my $in = <>;
chomp $in;

sub expand ($str, $recurse = 0) {
	my $count = Math::BigInt->bzero();
	while ($str =~ /\G (.*?) [(] (\d++) x (\d++) [)]/cgx) {
		my $len = Math::BigInt->new($2);
		my $repeat = int $3;
		$count->badd(length($1));

		my $payload = substr $str, pos($str), $2;
		pos($str) += $2;

		$len = expand($payload, $recurse + 1) if $recurse;
		$len->bmul($repeat);
		$count->badd($len);
	}

	$count->badd(length($str) - (pos($str) // 0));
	return $count;
}

say 'part 1: ', expand($in, 0);
say 'part 2: ', expand($in, 1);
