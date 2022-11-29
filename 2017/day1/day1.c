#include <stdio.h>
#include <stdlib.h>

int main() {
	int part1 = 0;
	int part2 = 0;

	char *input = NULL;
	size_t bufsize = 0;
	ssize_t len;

	len = getline(&input, &bufsize, stdin);

	if (len <= 0) {
		fputs("failed to read data\n", stderr);
		exit(1);
	}

	if (input[len - 1] == 10) input[ --len ] = 0;
	int half = len / 2;

	for (int i = 0; i < len; i++) {
		if (input[i] == input[ (i + 1) % len ])
			part1 += input[i] - 48;

		if (input[i] == input[ (i + half) % len ])
			part2 += input[i] - 48;
	}

	printf("part 1: %d\npart 2: %d\n", part1, part2);

	return 0;
}
