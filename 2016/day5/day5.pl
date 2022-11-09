#!/usr/bin/perl
use v5.18;
use warnings;
use Digest::MD5 'md5_hex';

my $hash;
my @spin = qw(- \ | /);
my ($index, $part1, $part2) = (0, '', ' ' x 8);
my ($p1_count, $p2_count) = (8, 8);
chomp( my $door = <> );

$| = 1;
while () {
	$hash = md5_hex $door, $index++;
	if ($hash =~ /^00000(.)(.)/) {
		if ($p1_count) {
			$part1 .= $1;
			$p1_count--;
		}

		if (hex($1) < 8 and ' ' eq substr $part2, $1, 1) {
			substr $part2, $1, 1, $2;
			$p2_count--;
		}

		printf "%s%10d [%-8s] [%s]\n", $hash, $index, $part1, $part2;
		last unless $p2_count or $p1_count;
	}

	# spinner alone adds about 10% to execution time
	#print '  ', $spin[($index >> 16) & 0x3], chr(13) unless $index & 0xff;
}

say STDERR "part 1: $part1";
say STDERR "part 2: $part2";
