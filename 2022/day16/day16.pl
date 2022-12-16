#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'max';

my %graph;
my $cost = {};
my $n = 0;

sub dfs {
	$n++;
	my ($here, $flow, $total, $mins, $used) = @_;
	if (! $used) {
		$used = {};
		$used->@{ keys %$cost } = ();
	}
	my $amt = 0;

	my @next = grep {!$used->{$_} and $cost->{$here}{$_} < $mins} keys $cost->{$here}->%*;

	if (@next) {
		for my $to (@next) {
			$used->{$to} = 1;
			$amt = max $amt, dfs(
				$to,
				$flow + $graph{$to}->[1],
				$total + $cost->{$here}{$to} * $flow,
				$mins - $cost->{$here}{$to},
				$used);
			$used->{$to} = 0;
		}
	} else {
		$amt = $total + $flow * $mins;
	}

	return $amt;
}

while (<>) {
	my ($name, $flow, @to) = /[A-Z]{2}|\d+/g;
	$graph{$name} = [$name, int($flow), \@to];
}

my @nodes = keys %graph;

for my $from ('AA', grep {$graph{$_}->[1]} @nodes) {
	my %work;
	@work{@nodes} = ();
	delete $work{$from};
	my $breadth = $graph{$from}->[2];
	my $step = 0;

	while (@$breadth) {
		$step++;
		my @next;
		for my $to (@$breadth) {
			if (exists $work{$to}) {
				push @next, $graph{$to}->[2]->@*;
				delete $work{$to};
				$cost->{$from}{$to} = $step + 1 if $graph{$to}->[1];
			}
		}
		$breadth = \@next;
	}
}

#for my $from (sort keys %$cost) {
#	for my $to (sort keys $cost->{$from}->%*) {
#		say "${from} => $to ", $cost->{$from}{$to};
#	}
#}

say dfs('AA', 0, 0, 30);
say $n;
