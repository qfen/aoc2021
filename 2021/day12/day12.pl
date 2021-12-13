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

my @work = ( ['end', 0] );
my ($path, $node, $tmplist);
while ($path = pop @work) {
	for $node ($graph{$path->[0]}->@*) {
		$tmplist = [$node, @$path];
		if ($node eq 'start') {
			$routes[$tmplist->[-1]]++;
		} else {
			if ($node =~ /[A-Z]/) {
				push @work, $tmplist;
			} else {
				next if $node eq 'end';
				if (!any { $node eq $_ } @$path) {
					push @work, $tmplist;
				} elsif ($tmplist->[-1] == 0) {
					$tmplist->[-1] = 1;
					push @work, $tmplist;
				}
			}
		}
	}
}

say 'part 1: ', $routes[0];
say 'part 2: ', $routes[0] + $routes[1];
