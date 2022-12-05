#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'max';
use POSIX 'ceil';

sub combine {
	my $result = [ join ', ', map { $_->[0] } @_ ];
	for my $input (@_) {
		$result->[$_] += $input->[$_] for (1 .. $#$input);
	}
	return $result;
}

my %shop = (	# name cost damage armor
	'weapons' => [
		['Dagger', 8, 4, 0],
		['Shortsword', 10, 5, 0],
		['Warhammer', 25, 6, 0],
		['Longsword', 40, 7, 0],
		['Greataxe', 74, 8, 0]
	],
	'armor' => [
		['none', 0, 0, 0],
		['Leather', 13, 0, 1],
		['Chainmail', 31, 0, 2],
		['Splintmail', 53, 0, 3],
		['Bandedmail', 75, 0, 4],
		['Platemail', 102, 0, 5]
	],
	'rings' => [
		['none', 0, 0, 0],
		['none', 0, 0, 0],
		['Damage +1', 25, 1, 0],
		['Damage +2', 50, 2, 0],
		['Damage +3', 100, 3, 0],
		['Defense +1', 20, 0, 1],
		['Defense +2', 40, 0, 2],
		['Defense +3', 80, 0, 3]
	]
);

EXPAND_RINGS: { # replaces 'rings' key above
	my @temp;
	for my $i (0 .. $#{ $shop{'rings'} }) {
		for my $j ($i + 1 .. $#{ $shop{'rings'} }) {
			push @temp, combine($shop{'rings'}->@[$i, $j]);
		}
	}
	$shop{'rings'} = \@temp;
}

my ($part1, $part2) = (~0, 0);

#Hit Points: 104
#Damage: 8
#Armor: 1
my %boss;
$boss{$1} = int($2) while ((<> // '') =~ /^([a-z ]+): (\d+)/i);

for my $weap ($shop{'weapons'}->@*) {
	for my $arm ($shop{'armor'}->@*) {
		for my $ring ($shop{'rings'}->@*) {
			my $stats = combine($weap, $arm, $ring);
			my $p_turns = ceil( $boss{'Hit Points'} / max($stats->[2] - $boss{'Armor'}, 1) );
			my $b_turns = ceil( 100 / max($boss{'Damage'} - $stats->[3], 1) );

			if ($p_turns <= $b_turns and $stats->[1] < $part1) {
				$part1 = $stats->[1];
			}

			if ($p_turns > $b_turns and $stats->[1] > $part2) {
				$part2 = $stats->[1];
			}
		}
	}
}

say "part 1: $part1";
say "part 2: $part2";
