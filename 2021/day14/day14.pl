#!/usr/bin/perl
use v5.28;
use warnings;
use List::Util qw(max min);

sub score { max(values $_[0]->%*) - min(values $_[0]->%*) }

my ($line, $prev);
my (%rule, %count, %work, %temp, $num, $ref);

# reading input
$line = <STDIN>;
chomp $line;
for (split //, $line) {
	$count{$_}++;
	$work{$prev . $_}++ if $prev;
	$prev = $_;
}

while ($line = <STDIN>) {
	next unless $line =~ /^([A-Z]{2}) -> ([A-Z])$/;
	$rule{$1} = [ $2, substr($1, 0, 1) . $2, $2 . substr($1, 1, 1) ];
}

# doing work
for (my $n = 1; $n <= 40; $n++) {
	%temp = ();
	for my $input (keys %work) {
		$num = $work{$input};
		$ref = $rule{$input};
		$count{$ref->[0]} += $num;
		$temp{$ref->[1]} += $num;
		$temp{$ref->[2]} += $num;
	}
	%work = %temp;
	say 'part 1: ', score(\%count) if $n == 10;
}

say 'part 2: ', score(\%count);
