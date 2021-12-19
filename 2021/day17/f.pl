#!/usr/bin/perl
use v5.28;
use warnings;
use POSIX qw(ceil floor);

my ($v, $y1, $y2) = map { int } @ARGV;
($y1, $y2) = ($y2, $y1) if $y1 > $y2;

sub t {
	my ($v, $yb) = @_;
	$v += 0.5;
	return $v + sqrt($v**2 - 2 * $yb);
}

sub ft {
	my ($v, $t) = @_;
	return (-$t * $t + $t) / 2 + $v * $t;
}

my $t1 = t($v, $y1);
my $t2 = t($v, $y2);
printf "v0=$v, enter $y2 at t=%.04f f(%d)=%f exit $y1 at t=%.04f f(%d)=%f\n",
	$t2,
	ceil($t2),
	ft($v, ceil($t2)),
	$t1,
	floor($t1),
	ft($v, floor($t1));
say join ',', ceil($t2)..floor($t1);
