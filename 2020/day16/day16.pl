#!/usr/bin/perl
use v5.18;
use warnings;

my %rules;
my $part1;
my $mine;
my %ban;
my %poss;

# is arg 0 between either args 1-2 or 3-4?
sub birange { $_[1] <= $_[0] <= $_[2] or $_[3] <= $_[0] <= $_[4] }

while (<> =~ /^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)$/i) {
	$rules{$1} = [ [], [ map { int } ($2, $3, $4, $5) ] ];
}

my $len = scalar keys %rules;

LINE:
while (<>) {
	next unless /^\d/;
	my @ticket = map { int } split /,/;
	$mine = \@ticket unless $mine;
	die 'weird line' unless $len == scalar @ticket;

	my %temp;
	for my $i (0 .. $#ticket) {
		# build up a list of fields this number violates
		for my $field (keys %rules) {
			if (! birange($ticket[$i], $rules{$field}->[1]->@*)) {
				push $temp{$field}->@*, $i;
			}
		}

		# if it violates every constraint, the ticket is invalid, move on
		# TODO: consider that one ticket might have multiple bad numbers...
		if ($len == scalar keys %temp) {
			$part1 += $ticket[$i];
			next LINE;
		}
	}

	# if we're still here, merge the temp list into the ban list
	for (keys %temp) {
		push $ban{$_}->@*, $temp{$_}->@*;
	}
}

say "part 1: $part1";

# 'invert' the sense of the banned list to produce a list of possibilities
for my $field (sort keys %ban) {
	my %temp;
	@temp{0 .. $len - 1} = ();
	delete $temp{$_} for $ban{$field}->@*;
	$poss{$field} = [ sort {$a <=> $b} keys %temp ];
}

# this just picks the first option, which happens to work on my input
# TODO: depth-first search in case first available gets into a dead end
my %used;
my @ordered = sort {$poss{$a}->@* <=> $poss{$b}->@*} keys %poss;
FIELD: for my $field (@ordered) {
	for my $option ($poss{$field}->@*) {
		next if $used{$option};
		$used{$option} = $field;
		next FIELD;
	}
}

# multiply together the values from my ticket for the "departure *" fields
my $part2 = 1;
for (sort {$a <=> $b} keys %used) {
	$part2 *= $mine->[$_] if $used{$_} =~ /^departure/i;
}
say "part 2: $part2";
