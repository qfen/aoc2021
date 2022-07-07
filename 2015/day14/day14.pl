#!/usr/bin/perl
use v5.28;
use warnings;

use constant {
	NAME => 0,
	SPEED => 1,
	DUTY => 2,
	CYCLE => 3,
	CYC_DIST => 4,
	ACCUM_DIST => 5,
	TICK => 6,
	SCORE => 7
};

my @deer;

while (<STDIN>) {
	chomp;
	/^([a-z]+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds.$/i or die 'weird line';
	my($go_speed, $go_time, $rest_time) = map { int } $2, $3, $4;
	my($cyc_time, $cyc_dist) = ($go_time + $rest_time, $go_speed * $go_time);
	push @deer, [
		$1,
		$go_speed,
		$go_time,
		$cyc_time,
		$cyc_dist,
		0, 0, 0
	];

	#my $dist = 0;
	#my $timer = 2503;
	#while ($timer > $cyc_time) {
	#	$timer -= $cyc_time;
	#	$dist += $cyc_dist;
	#}
	#if ($timer >= $go_time) {
	#	$dist += $cyc_dist;
	#} else {
	#	$dist += $go_speed * $timer;
	#}
	#say "$1: $dist";
	#$best = $dist if $dist > $best;
}

my ($best_score, $best_dist) = (0, 0);
my @leading;

my $ticks = int( $ARGV[0] // 2503 );

for (1 .. $ticks) {
	@leading = ();
	for (@deer) {
		# advance distance in the 'go' phase, and increment phase TICK modulo the cycle time
		$_->[ ACCUM_DIST ] += $_->[ SPEED ] if $_->[ TICK ] < $_->[ DUTY ];
		$_->[ TICK ] = ($_->[ TICK ] + 1) % $_->[ CYCLE ];

		# manage the list of current leaders
		if ($_->[ ACCUM_DIST ] > $best_dist) {
			$best_dist = $_->[ ACCUM_DIST ];
			@leading = ();
		}

		push @leading, $_ if $_->[ ACCUM_DIST ] == $best_dist;
	}

	#my $msg = $_;
	for (@leading) {
		$_->[ SCORE ]++;
		$best_score = $_->[ SCORE ] if $_->[ SCORE ] > $best_score;
		#$msg .= join(' ', ',', $_->@[ NAME, SCORE ]);
	}
	#say $msg;
}

say 'part 1: ', $best_dist;
say 'part 2: ', $best_score;
