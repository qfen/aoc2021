#!/usr/bin/perl -w
use v5.28;
use warnings;
use Scalar::Util qw(looks_like_number reftype);
use JSON::PP;

sub recurse {
	my $ref = shift;
	my $part1 = 0;
	my $part2 = 0;
	my $has_red = 0;
	for (reftype $ref) {
		no warnings 'experimental::smartmatch';
		when (!defined $_) {
			$part1 = $part2 = $ref if looks_like_number $ref;
		}

		when ('ARRAY') {
			for (@$ref) {
				my ($temp1, $temp2) = recurse($_);
				$part1 += $temp1;
				$part2 += $temp2;
			}
		}

		when ('HASH') {
			for (keys %$ref) {
				my ($temp1, $temp2) = recurse($ref->{$_});
				$part1 += $temp1;
				$part2 += $temp2;
				$has_red = 1 if 'red' eq lc $ref->{$_};
			}
		}
	}

	return ($part1, $has_red ? 0 : $part2);
}

my $jref;

{	local $/;
	$jref = decode_json <STDIN>;
}

printf "part 1: %d\npart 2: %d\n", recurse($jref);
