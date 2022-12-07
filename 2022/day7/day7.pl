#!/usr/bin/perl
use v5.18;
use warnings;
use List::Util 'first';

my $root = [undef, undef, undef]; # size, children, parent
my $cwd = $root;
my ($part1, @sizes);

<> eq "\$ cd /\n" or die "don't know how to start below root";

while (<>) {
	/^(?:	(?: dir | (\d+) ) [ ] ([.a-z]+) |
		\$ [ ] (?:
			ls |
			cd [ ] (?: (\.\.) | ([.a-z]+) ) )
	)$/x or die 'weird line';

	if ($2) {
		if ($1) { # NN... name
			$cwd->[0] += int $1;
			$cwd->[1]{$2} = [int $1, undef, $cwd];
		} else { # dir name
			$cwd->[1]{$2} = [0, { }, $cwd];
		}
	} else {
		if ($3) { # cd ..
			push @sizes, $cwd->[0];
			$part1 += $cwd->[0] if $cwd->[0] <= 100_000;

			$cwd->[2][0] += $cwd->[0];
			$cwd = $cwd->[2] or die "bad tree";
		} elsif ($4) { # cd name
			$cwd = $cwd->[1]{$4} or die "nonexistent '$4'";
		} # ls: noop
	}
}

while ($cwd != $root) {
	push @sizes, $cwd->[0];
	$part1 += $cwd->[0] if $cwd->[0] <= 100_000;
	$cwd->[2][0] += $cwd->[0];
	$cwd = $cwd->[2];
}

#sub show {
#	my ($n, $tree) = @_;
#	for (sort keys %$tree) {
#		my $node = $tree->{$_};
#		if (ref($node->[1]) eq 'HASH') {
#			say '    ' x $n, "${_}/ $node->[0]";
#			show($n + 1, $node->[1]);
#		} else {
#			say '    ' x $n, "$_  $node->[0]";
#		}
#	}
#}
#show(0, {'' => $root});

say "part 1: $part1";
say 'part 2: ', first { $_ >= $root->[0] - 40_000_000 } sort { $a <=> $b } @sizes;
