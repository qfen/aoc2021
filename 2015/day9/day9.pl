#!/usr/bin/perl
use v5.28;
use warnings;
use Data::Dumper;

use FindBin;
use lib "$FindBin::RealBin/../lib";
use Enum;

my (@dist, %name, %rev);
my $part1 = ~0;
my $part2 = 0;
my (@part1_rte, @part2_rte);

sub cost {
	my $sum = 0;

	for my $i (1 .. $#_) {
		$sum += $dist[$_[$i-1]][$_[$i]];
	}

	if ($sum < $part1) {
		#warn "improve to dist $sum by {@_}";
		$part1 = $sum;
		@part1_rte = @_;
	}

	if ($sum > $part2) {
		#warn "improve part2 to dist $sum by {@_}";
		$part2 = $sum;
		@part2_rte = @_;
	}

	return 1;
}

while (<>) {
	chomp;
	/^(.+) to (.+) = (\d+)$/ or die 'weird line';
	for ($1, $2) {
		if (! exists $name{$_}) {
			push @dist, [];
			$name{$_} = $#dist;
			$rev{$#dist} = $_;
		}
	}

	$dist[$name{$1}]->[$name{$2}] = $dist[$name{$2}]->[$name{$1}] = int $3;
}

Enum::k_perm_each(\&cost, [0 .. $#dist]);

say "part 1: $part1";
#say join ' ', "shortest route:", map {$rev{$_}} @part1_rte;

say "part 2: $part2";
#say join ' ', "longest route:", map {$rev{$_}} @part2_rte;
