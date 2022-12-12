#!/usr/bin/perl
use v5.18;
use warnings;

my $map = [];
my $q = [];
my @dirs = ( [-1,0], [1,0], [0,-1], [0,1] );
my ($step, $tgt_x, $tgt_y);

while (<>) {
	# height, steps to reach
	chomp;
	push @$map, [ map { [ -97 + ord, undef ] } split // ];

	if ((my $x = index $_, 'E') >= 0) {
		$map->[-1][$x] = [26, 0];
		push @$q, [$. - 1, $x];
	}

	if ((my $x = index $_, 'S') >= 0) {
		$map->[-1][$x][0] = 0;
	}
}

OO:
while (@$q) {
	my ($y, $x) = @{ shift @$q };
	my ($here, $step) = @{ $map->[$y][$x] };

	for (@dirs) {
		my ($to_y, $to_x) = ($y + $_->[0], $x + $_->[1]);
		next unless 0 <= $to_y <= $#$map and 0 <= $to_x < scalar($map->[0]->@*);
		my $ref = $map->[ $to_y ][ $to_x ];

		if (!defined $ref->[1] and (-$ref->[0] + $here) <= 1) {
			if ($ref->[0] == 0) {
				say 'part 2: ', $step + 1; last OO;
			}
			$ref->[1] = $step + 1;
			push @$q, [ $to_y, $to_x ];
		}
	}
}

