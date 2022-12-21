#!/usr/bin/perl
use v5.18;
use warnings;

my (%known, %todo);

while (<>) {
	m!^([a-z]+): \s* (?:
		(\d+) |
		([a-z]+) \s* ([-+/*]) \s* ([a-z]+) )$
	!x or die 'weird line';

	if (defined $2) {
		$known{$1} = int $2;
	} else {
		$todo{$1} = [
			$3,
			$5,
			eval qq/sub { \$known{"$3"} $4 \$known{"$5"} }/
		];
	}
}

while (keys %todo) {
	for my $key (keys %todo) {
		my $ref = $todo{$key};
		if (exists $known{$ref->[0]} and exists $known{$ref->[1]}) {
			delete $todo{$key};
			$known{$key} = $ref->[2]();
		}
	}
}

say "part 1: $known{root}";
