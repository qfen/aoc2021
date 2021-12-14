#!/usr/bin/perl
use v5.28;
use warnings;
use List::Util qw(max min);

my ($line, %rule, @poly, @work, $i, $n);
my (%part1);

$line = <STDIN>;
chomp $line;
@poly = split //, $line;

while ($line = <STDIN>) {
	next unless $line =~ /^([A-Z]{2}) -> ([A-Z])$/;
	$rule{$1} = $2;
}

$n = 10;
@work = @poly;
while ($n--) {
	say $n;
	for ($i = $#poly; $i; $i--) {
		splice @work, $i, 0, $rule{$poly[$i - 1] . $poly[$i]};
	}
	@poly = @work;
}

$part1{$_}++ for @poly;

say 'part 1: ', max(values %part1) - min(values %part1);
