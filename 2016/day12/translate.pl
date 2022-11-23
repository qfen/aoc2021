#!/usr/bin/perl
use v5.18;
use warnings;

my $lbl = 0;
my @lines;
my $max = 0;

print <<EOF;
; day12.asm
global day12asm

; int day12asm(int abcd[4])
day12asm:
	push ebx
	push edi

	; some inputs may actually need this
	mov edi, [esp + 12]
	mov eax, [edi]
	mov ebx, [edi + 4]
	mov ecx, [edi + 8]
	mov edx, [edi + 12]

EOF

while (<>) {
	chomp;
	my $comment = $_;
	my $mnemonic;

	$_ =~ s/\b([abcd])\b/e${1}x/g;

	if (/^jnz (?:(\d+)|(e[abcd]x)) (-?\d+)$/) {
		if (defined($1) and $1) {
			$mnemonic = sprintf "jmp L%02d", $lbl + $3;
			$lines[$lbl + $3]->[0] = 1;
		} else {
			$mnemonic = sprintf "test $2, $2\n\tjnz L%02d", $lbl + $3;
			$lines[$lbl + $3]->[0] = 1;
		}
	} else {
		$mnemonic = "inc $1" if /^inc (e[abcd]x)/;
		$mnemonic = "dec $1" if /^dec (e[abcd]x)/;
		$mnemonic = "mov $2, $1" if /^cpy (.*) (.*)$/;
	}

	while ($mnemonic =~ /^\t?(.*)$/gm) {
		$max = length($1) if $max < length $1;
	}

	$lines[$lbl]->@[1, 2] = ($mnemonic, $comment);
	$lbl++;
}

my $tabs = $max / 8;
$tabs = 1 + int $tabs if $tabs > int $tabs;

for my $i (0 .. $#lines) {
	$lines[$i]->[1] =~ /(^|\n\t)(.*)$/;
	my $len = length $2;

	printf "%s\t%s%s; %s\n",
		$lines[$i]->[0] ? sprintf("L%02d:", $i) : '',
		$lines[$i]->[1],
		"\t" x ($tabs - int($len / 8)),
		$lines[$i]->[2];
}

print <<EOF;

	mov [edi], eax
	mov [edi + 4], ebx
	mov [edi + 8], ecx
	mov [edi + 12], edx

	pop edi
	pop ebx
	ret
EOF

warn <<'EOF';
$ nasm -felf32 day12.asm
$ gcc -m32 -o day12 day12.o day12.c
EOF

open my $fh, '>', 'day12.c' or die "can't write day12.c";
print $fh <<'EOF';
/* day12.c */
#include <stdio.h>
#include <string.h>

extern int day12asm(int abcd[4]);

int main(void) {
	int r[4] = {0, 0, 0, 0};
	int result;

	printf("day12asm(%d, %d, %d, %d)\n", r[0], r[1], r[2], r[3]);
	result = day12asm(r);
	printf("a:%d, b:%d, c:%d, d:%d\n", result, r[1], r[2], r[3]);

	memset((void *)r, 0, (size_t) 4 * sizeof(int));
	r[2] = 1;
	printf("day12asm(%d, %d, %d, %d)\n", r[0], r[1], r[2], r[3]);
	result = day12asm(r);
	printf("a:%d, b:%d, c:%d, d:%d\n", result, r[1], r[2], r[3]);

	return 0;
}
EOF
