(() => {
	const TIMER = '2021/day6';
	console.time(TIMER);

	let state = Array(9).fill(0);
	$('pre').textContent.trim().split(',').forEach(s => state[parseInt(s)]++);
	let part1, sum = state.reduce((a, b) => a + b);

	for (let i = 1; i <= 256; i++) {
		sum += state[8] = state.shift();
		state[6] += state[8];
		if (i == 80) part1 = sum;
	}

	console.log(`part 1: ${part1}\npart 2: ${sum}`);
	console.timeEnd(TIMER);
})();
