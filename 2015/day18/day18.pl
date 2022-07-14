#!/usr/bin/perl
use v5.28;
use warnings;
use List::Util 'sum0';
use Storable 'dclone';

my $steps = int( $ARGV[0] // 100 );

my $part1 = [ map { [ 0 , map { ($_ eq '#') } split // ] } <STDIN> ];

my $width = scalar( $part1->[0]->@* );
unshift @$part1, [ (0) x $width ];
push @$part1, [ (0) x $width ];
my $height = @$part1;
my $part2 = dclone($part1);

warn "simulate $steps steps ($width x $height)";

$part2->[1][1] = 1;
$part2->[1][$width - 2] = 1;
$part2->[$height - 2][1] = 1;
$part2->[$height - 2][$width - 2] = 1;

my ($y, $x, $neighbors, $n2, $x_look, $y_look);
for my $step (1 .. $steps) {
	my $next_part1 = [ undef ];
	my $next_part2 = [ undef ];

	for $y (1 .. $height - 2) {
		push @$next_part1, [ 0 ];
		push @$next_part2, [ 0 ];

		for $x (1 .. $width - 2) {
			($neighbors, $n2) = (0, 0);

			for $x_look ($x - 1 .. $x + 1) {
				for $y_look ($y - 1 .. $y + 1) {
					no warnings 'numeric';
					$neighbors += $part1->[ $y_look ][ $x_look ];
					$n2 += $part2->[ $y_look ][ $x_look ];
				}
			}

			$next_part1->[$y][$x] = ($neighbors == 3 or ($neighbors == 4 and $part1->[$y][$x]));
			$next_part2->[$y][$x] = ($n2 == 3 or ($n2 == 4 and $part2->[$y][$x]));
		}

		push $next_part1->[$y]->@*, 0;
		push $next_part2->[$y]->@*, 0;
	}

	$part1->@[1 .. $height - 2] = $next_part1->@[1 .. $height - 2];

	$next_part2->[1][1] = 1;
	$next_part2->[1][$width - 2] = 1;
	$next_part2->[$height - 2][1] = 1;
	$next_part2->[$height - 2][$width - 2] = 1;
	$part2->@[1 .. $height - 2] = $next_part2->@[1 .. $height - 2];
}

say 'part 1: ', sum0 map { scalar grep { $_ } @$_ } @$part1;
say 'part 2: ', sum0 map { scalar grep { $_ } @$_ } @$part2;
