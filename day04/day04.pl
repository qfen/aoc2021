#!/usr/local/bin/perl
# https://adventofcode.com/2021/day/4
# https://adventofcode.com/2021/day/4/input

use v5.28;
use warnings;
use List::Util 'sum0';

sub read_board {
	my($text, $row);
	my $sum = 0;
	my $board = [];
	while ($text = <STDIN>) {
		chomp $text;
		last if $text =~ /^\s*$/;

		$row = [ map { int } grep({ length } split(/\s+/, $text)) ];
		warn "weird rowsize ", scalar(@$row) if @$row != 5;
		$sum += sum0 @$row;
		push @$board, $row;
	}

	return ($sum, $board);
}

sub score_board {
	my($list, $sum, $board) = @_;
	my($index, $num, $row, $col);

	for $index (0 .. $#$list) {
		$num = $list->[$index];
		for $row (0 .. 4) {
			for $col (0 .. 4) {
				if ($num == $board->[$row][$col]) {
					$sum -= $num;
					if (	++$board->[$row][5] == 5 or
						++$board->[5][$col] == 5) {
						return ($index, $sum * $num);
					}
				}
			}
		}
	}

	warn "this board never won";
	return (undef, 0);
}

my($line, @seq, $sum, $board, $index, $score);
my($first_win, $first_score) = (~0, 0);

$line = <STDIN>;
chomp $line;
@seq = map { int } split(/,/, $line);

while (! eof STDIN) {
	($sum, $board) = read_board();
	next if $sum == 0;
	($index, $score) = score_board(\@seq, $sum, $board);
	if ($index < $first_win) {
		$first_win = $index;
		$first_score = $score;
	}
}

say "part 1 score: $first_score";
