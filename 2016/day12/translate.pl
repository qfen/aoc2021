#!/usr/bin/perl
use v5.18;
use warnings;

my $lbl = 0;

print <<EOF;
extern printf

section .data:
	msg: db "a:%d, b:%d, c:%d, d:%d", 10, 0

section .text:
	global main

main:
	push ebp
	mov ebp, esp
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

EOF

while (<>) {
	s/\b([abcd])\b/e${1}x/g;

	printf "L%02d:\t", $lbl;

	if (/^jnz (?:(\d+)|(e[abcd]x)) (-?\d+)$/) {
		if (defined($1) and $1) {
			printf "jmp L%02d", $lbl + $3;
		} else {
			printf "test $2, $2\n\tjnz L%02d", $lbl + $3;
		}
	} else {
		print "inc $1" if /^inc (e[abcd]x)/;
		print "dec $1" if /^dec (e[abcd]x)/;
		print "mov $2, $1" if /^cpy (.*) (.*)$/;
	}
	print "\t\t; $_";

	$lbl++;
}

print <<EOF;

	push edx
	push ecx
	push ebx
	push eax
	push msg
	call printf

	mov eax, 0
	leave
	ret
EOF

warn <<'EOF';
$ nasm -felf32 day11.asm
$ gcc -m32 -o day11 day11.o
EOF
