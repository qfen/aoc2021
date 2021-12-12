#!/usr/bin/perl

use v5.28;
use warnings;
use List::Util 'any';

my (%graph, @routes);

while (<STDIN>) {
	/^([a-z]+)-([a-z]+)$/i or die "weird line";
	push $graph{$1}->@*, $2;
	push $graph{$2}->@*, $1;
}

my @work = ( ['end'] );
my ($path, $node);
while ($path = pop @work) {
	for $node ($graph{$path->[0]}->@*) {
		if ($node eq 'start') {
			push @routes, ['start', @$path];
			#printf "route %02d %s\n", scalar @routes, join(' > ', $routes[$#routes]->@*);
		} elsif ($node =~ /[A-Z]/ or !any { $node eq $_ } @$path) {
			push @work, [$node, @$path];
		}
	}
}

say 'part 1: ', scalar @routes;
