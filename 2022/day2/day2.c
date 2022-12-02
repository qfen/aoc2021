#include <assert.h>
#include <stdio.h>

int main() {
	int part1 = 0, part2 = 0;
	int opp, own;
	char a, b;
	int temp1, temp2;

	while (scanf("%c %c\n", &a, &b) == 2) {
		assert(a >= 'A' && a <= 'C' && b >= 'X' && b <= 'Z');
		opp = (int) (a - 'A');
		own = (int) (b - 'W');

		// C % operator must be adjusted to be non-negative
		temp1 = (own - opp) % 3;
		if (temp1 < 0) temp1 += 3;
		temp2 = (opp + own - 2) % 3;
		if (temp2 < 0) temp2 += 3;

		assert(temp1 >= 0 && temp2 >= 0);

		part1 += (own) + (3 * temp1);
		part2 += (temp2 + 1) + (3 * (own - 1));
	}

	if (! feof(stdin)) {
		fprintf(stderr, "trailing input");
		return 1;
	}

	printf("part 1: %d\npart 2: %d\n", part1, part2);

	return 0;
}
