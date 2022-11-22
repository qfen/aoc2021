#!/usr/bin/perl
use v5.18;
use warnings;

my ($a, $b, $c, $d, $i, @inst);

while (<>) {
	chomp;
	s/\b([abcd])\b/\$$1/g;

	my $str = '';
	if (/^jnz (.*) (-?\d+)$/) {
		$str = "\$i += ( $1 ? $2 : 1 )";
	} else {
		$str = "$1++" if /^inc (\$[abcd])/;
		$str = "$1--" if /^dec (\$[abcd])/;
		$str = "$2 = $1" if /^cpy (.*) (.*)$/;
		$str .= '; $i++';
	}

	push @inst, eval( 'sub { ' . $str . ' }' );
}

sub emulate($$$$) {
	($i, $a, $b, $c, $d) = (0, @_);
	my $steps;

	while ($i < @inst) {
		$inst[$i]->();
		$steps++;
	}

	return ($a, $b, $c, $d, $steps);
}

printf "part 1: a:%d b:%d c:%d d:%d (%d dispatched)\n", emulate(0, 0, 0, 0);
printf "part 2: a:%d b:%d c:%d d:%d (%d dispatched)\n", emulate(0, 0, 1, 0);
