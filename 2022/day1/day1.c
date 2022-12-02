#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

#define STARTBUF 32

int cmp(const void *a, const void *b) {
	return *(int *)b - *(int *)a;
}

int main() {
	char *line = NULL;
	size_t bufsize = 0;
	ssize_t len;

	int * sums = NULL;
	int sumlen = STARTBUF;
	int slot = 0;
	int accum = 0;

	sums = realloc((void *)sums, sumlen * sizeof(int));
	if (sums == NULL) exit(1);

	while (len = getline(&line, &bufsize, stdin) != -1) {
		if (line[0] == '\n') {
			if (slot == sumlen) {
				sumlen <<= 1;
				sums = (int *)realloc((void *)sums, sumlen * sizeof(int));

				if (sums == NULL) exit(2);
			}

			sums[slot] = accum;
			accum = 0;
			slot++;
		} else {
			accum += strtol(line, NULL, 10);

			if (errno == EINVAL) {
				fprintf(stderr, "line %d weird number: '%s'\n", slot+1, line);
				exit(3);
			}
		}
	}

	// TODO: something is wrong here with a paragraph summing to 44617
	qsort((void *)sums, slot, sizeof(int), cmp);

	printf("part 1: %d\npart 2: %d\n", sums[0], sums[0] + sums[1] + sums[2]);

	return 0;
}
