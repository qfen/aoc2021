package Enum;
use strict;
use warnings;

use Carp;
use Exporter 'import';
use Math::BigInt;
use Scalar::Util 'looks_like_number';

use constant PERMUTATION => 1;
use constant COMBINATION => 2;

our @EXPORT_OK = qw( );
our $VERSION = '0.02';

# Usage: my $gen = kcomb_gen(n, k); my $vector = &$gen() ...
# returns sub that yields the next characteristic vector, or undef when the
# space is exhausted
sub k_comb_gen {
	my($n, $k) = @_;
	croak 'no combinations' and return unless 0 < ($k // 0) <= $n;
	croak 'big vectors not implemented' if (1 << $n) == 0;

	# https://en.wikipedia.org/wiki/Combinatorial_number_system
	my($limit, $vec) = (1<<$n, (1<<$k) - 1);
	my $gen = sub {
		my($ubit, $vbit, $result);
		if ($vec < $limit) {
			$result = $vec;
			$ubit = $vec & -$vec;
			$vbit = $ubit + $vec;
			$vec = $vbit + ((($vbit^$vec)/$ubit)>>2);
		}
		return $result;
	};

	return wantarray ? ($gen, &$gen(), count_comb($n, $k)) : $gen;
}

# https://academic.oup.com/comjnl/article/6/3/293/360213
# https://tinypig2.blogspot.com/2016/12/heaps-algorithm-and-generating-perl.html
# https://www.cs.princeton.edu/~rs/talks/perms.pdf
sub perm_gen {
	my $list = shift;
	croak 'need array reference' if ref($list) ne 'ARRAY';
	my($i, $x, $count) = (0, 0, 0);
	my @c = (0) x scalar @$list;

	my $gen = sub {
		while ($i < scalar @$list) {
			if ($c[$i] < $i) {
				$x = $i % 2 ? $c[$i] : 0;
				@{$list}[$x, $i] = @{$list}[$i, $x];
				$c[$i]++;
				$i = 0;
				return ++$count;
			} else {
				$c[$i] = 0;
				$i++;
			}
		}
		return undef;
	};

	return wantarray ? ($gen, count_perm(scalar @$list, scalar @$list)) : $gen;
}

sub _make_subset {
	my($dest, $src, $vector) = @_;
	my $offset = 0;
	return undef unless $vector;

	splice @$dest;
	while ($vector) {
		push @$dest, $src->[$offset] if $vector & 1;
		$offset++;
		$vector >>= 1;
	}
	return 1;
}

sub k_perm_gen {
	my($dest, $src) = (shift, shift);
	croak 'need array references' if ref($src) ne 'ARRAY' or ref($dest) ne 'ARRAY';
	my $n = scalar @$src;
	my $k = int(shift || $n);
	croak "k($k) not in (0..$n]" unless 0 < $k <= $n;

	my $vector_gen = k_comb_gen($n, $k);
	my($vector, $permute_gen, $count);

	my $gen = sub {
		if (!$permute_gen or !&$permute_gen()) {
			return undef unless $vector = &$vector_gen();
			_make_subset($dest, $src, $vector);
			$permute_gen = perm_gen($dest);
		}
		return ++$count;
	};

	return $gen;
}

# args: operation (constant), callback (code), list (array ref), [k]
sub _each {
	my($op, $cb, $list, $k) = @_;
	my $n;

	croak 'no callback function provided' unless ref($cb) eq 'CODE';
	croak 'no list provided' unless ref($list) eq 'ARRAY' and ($n = @$list) > 0;
	croak "non-numeric value for k($k)" if defined($k) and !looks_like_number($k);
	croak "k (n=$n,k=$k) out of range" unless 0 < ($k = int($k//$n)) <= $n;

	my $vector_gen = k_comb_gen(scalar @$list, $k);
	my(@worklist, $vector, $permute_gen, $count);

	OUTER: while (_make_subset(\@worklist, $list, $vector = &$vector_gen())) {
		$count++;
		last unless &$cb(@worklist);
		if ($op == PERMUTATION) {
			$permute_gen = perm_gen(\@worklist);
			while (&$permute_gen()) {
				$count++;
				last OUTER unless &$cb(@worklist);
			}
		}
	}

	return $count;
}

sub k_perm_each { return _each(PERMUTATION, @_); }
sub k_comb_each { return _each(COMBINATION, @_); }

sub _count {
	my($op, $n, $k, $big) = @_;
	my $bresult;

	unless (looks_like_number($n) and looks_like_number($k)) {
		carp 'non-numeric arguments';
		return undef;
	}

	unless (0 < $k <= $n) {
		carp "argument (n=$n,k=$k) out of range";
		return undef;
	}

	$bresult = Math::BigInt->new($n)->bfac();
	$bresult->bdiv(Math::BigInt->new($n - $k)->bfac());
	$bresult->bdiv(Math::BigInt->new($k)->bfac()) if $op == COMBINATION;

	if ($big) { # return bignum directly
		return $bresult;
	} else { # try to convert to integer
		carp 'integer overflow' if $bresult->bgt(~0);
		return $bresult->numify();
	}
}

# Args: n, k, big
sub count_perm { return _count(PERMUTATION, @_); }
sub count_comb { return _count(COMBINATION, @_); }

=head1 NAME

Enum - Enumerate combinations or permutations of a set

=head1 SYNOPSIS
  use Enum;
  my @set = (1,2,3);
  permute(\@set);

=head1 DESCRIPTION

Can be used to generate all k-combinations or k-permutations of a given set

=head2 EXPORT

TODO: export something

=cut

1;
