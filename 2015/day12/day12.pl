#!/usr/bin/perl -w
use v5.28;
use warnings;
use Scalar::Util qw(looks_like_number reftype);
use JSON::PP;

my $sum = 0;
sub recurse {
	my $ref = shift;
	for (reftype $ref) {
		no warnings 'experimental::smartmatch';
		when (!defined $_) {
			$sum += $ref if looks_like_number $ref;
		}

		when ('ARRAY') {
			recurse($_) for (@$ref);
		}

		when ('HASH') {
			recurse($ref->{$_}) for (keys %$ref);
		}
	}
}

my $jref;
{	local $/;
	my $json = <STDIN>;
	$jref = decode_json $json;
}

recurse($jref);
say 'part 1: ', $sum;
