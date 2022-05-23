#!/usr/bin/perl
use v5.28;
use warnings;
use Data::Dumper;
use constant DBG => 0;

my %vals;

sub dbg {
	return unless DBG;
	my ($lvl, $msg, @args) = @_;
	my $space = ' ' x (2 * $lvl);
	printf STDERR "$space$msg\n", @args;
}

sub recurse {
	my $id = shift;
	my $lvl = shift // 0;
	dbg($lvl, "compute $id");
	for ($vals{$id}->[2]->@*) {
		if (! defined $vals{$_}->[0]) {
			dbg($lvl, "recurse into $_");
			recurse($_, $lvl + 1);
		}
	}
	my $result = 0xFFFF & eval $vals{$id}->[3];
	$vals{$id}->[0] = $result;
	dbg($lvl, "$vals{$id}->[3] = $result -> $id");
	return $result;
}

while (<>) {
	/^(.*) -> ([a-z]+)$/ or die 'wtf';
	my ($expr, $dest) = ($1, $2);
	die "redef $dest (from line $vals{$dest}->[1])" if exists $vals{$dest};

	my @entry = ( undef, $., [ $expr =~ /[a-z]+/g ] );

	$expr =~ s/([a-z]+)/(\$vals{"$1"}->[0])/g;
	$expr =~ s/AND/&/;
	$expr =~ s/OR/|/;
	$expr =~ s/LSHIFT/<</;
	$expr =~ s/RSHIFT/>>/;
	$expr =~ s/NOT/~/;

	push @entry, $expr;

	$vals{$dest} = \@entry;
}

my $part1 = recurse('a');

$vals{$_}->[0] = undef for (keys %vals);
$vals{'b'}->[0] = $part1;
my $part2 = recurse('a');

say "part 1: $part1";
say "part 2: $part2";
