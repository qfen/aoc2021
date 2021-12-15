#!/usr/bin/perl
use v5.28;
use warnings;
use List::Util qw(max min);

my (%rule, %count, $prev);
my $work = {};

sub score { max(values $_[0]->%*) - min(values $_[0]->%*) }

sub polymer { # pass hashref of pairs to be expanded once
	my (%temp, $num, $ref);

	for my $input (keys $_[0]->%*) {
		$num = $_[0]->{$input};
		$ref = $rule{$input};
		$count{$ref->[0]} += $num;
		$temp{$ref->[1]} += $num;
		$temp{$ref->[2]} += $num;
	}

	return \%temp; # new state of worklist
}

while (<STDIN>) {
	chomp;
	if (/^[A-Z]+$/) { # "polymer template"
		for (split //, $_) {
			$count{$_}++;
			$work->{$prev . $_}++ if $prev;
			$prev = $_;
		}
	} elsif (/^([A-Z]{2}) -> ([A-Z])$/) { # "pair insertion" rules
		$rule{$1} = [ $2, substr($1, 0, 1) . $2, $2 . substr($1, 1, 1) ];
	}
}

$work = polymer($work) for (1 .. 10);
say 'part 1: ', score(\%count);

$work = polymer($work) for (11 .. 40);
say 'part 2: ', score(\%count);
