#!/usr/bin/perl
use v5.18;
use warnings;
use Data::Dumper;

$/ = '';
my @m;
my $mult = 1;

while (<>) {
	/^ Monkey [ ] \d+: $
	\s*	Starting [ ] items: [ ] ([\d, ]+) $
	\s*	Operation: [ ] new [ ] = [ ] (.*) $
	\s*	Test: [ ] divisible [ ] by [ ] (\d+) $
	\s*	(?^:If true: throw to monkey (\d+)) $
	\s*	(?^:If false: throw to monkey (\d+)) $
	/mx or die 'weird line';

	my ($op, $mod, $if_t, $if_f) = ($2, $3, $4, $5);
	my @list = map { int } split /,\s+/, $1;
	$op =~ s'old'$_[0]'g;
	$mult *= $mod;

	my $code = "sub {
	my \$w = int(($op) / 3);
	return (\$w, \$w % $mod ? $if_f : $if_t);
	}";

	push @m, [eval($code), 0, \@list];
}

for (1 .. 20) {
	for my $m (@m) {
		while (my $item = shift @{$m->[2]}) {
			$m->[1]++;
			my ($val, $tgt) = $m->[0]->($item);
			push $m[$tgt]->[2], $val % $mult;
		}
	}
}

for my $i (0 .. $#m) {
	warn "monkey $i $m[$i]->[1]\n";
}

my ($m1, $m2) = (sort {$b-$a} map { $_->[1] } @m)[0, 1];
say 'part 1: ', $m1 * $m2;
