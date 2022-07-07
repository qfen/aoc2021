#!/usr/bin/perl
use v5.28;
use warnings;
use Data::Dumper;
use constant DEBUG => 0;

use FindBin;
use lib "$FindBin::RealBin/../../lib";
use Enum;

my %name;
my @score;
my @rev;

sub score { # pass array of ordered indices
	my $sum = 0;
	my $size = scalar @_;
	for (0 .. $#_) {
		$sum += # this person's happiness is sum of their happiness with person to left and right
			$score[ $_[$_] ]->[ $_[($_ - 1) % $size] ] +
			$score[ $_[$_] ]->[ $_[($_ + 1) % $size] ];
	}
	return $sum;
}

sub arrange {
	my @order = 1 .. $#score;
	my $gen = Enum::perm_gen(\@order);
	my $best = -(~0 >> 1) - 1; # smallest signed integer
	my $current;

	do {
		$current = score(0, @order); # always start counting from index 0; from O(n!) down to (n-1)!
		if ($current > $best) {
			say "improved to $current (0, @order)" if DEBUG;
			$best = $current;
		}
	} while &$gen();

	return $best;
}

while (<STDIN>) {
	chomp;
	/^([a-z]+) would (?:gain|(lose)) (\d+) happiness units by sitting next to ([a-z]+)\.$/i or die 'weird line';
	for ($1, $4) {
		if (! exists $name{$_}) {
			push @score, [];
			$name{$_} = $#score;
			$rev[ $#score ] = $_;
		}
	}

	$score[ $name{$1} ]->[ $name{$4} ] = $2 ? 0 - $3 : 0 + $3;
}

say Dumper(\@score, \%name) if DEBUG;

say 'part 1: ', arrange();

# add a row for 'you'
$score[ $_ ]->[ scalar @score ] = 0 for 0 .. $#score;
push @score, [ (0) x scalar(@score) ];
$name{'you'} = $#score;
$rev[ $#score ] = 'you';

say 'part 2: ', arrange();
