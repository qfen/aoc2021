(() => {
	const TIMER = '2021/day7';
	console.time(TIMER);

	let input = $('pre').textContent
		.trim()
		.split(',')
		.map(s => Number.parseInt(s))
		.sort((a, b) => a - b);

	let median = input[input.length >> 1];
	let part1 = input.reduce((a, b) => a + Math.abs(b - median), 0);

	let mean = input.reduce((a, b) => a + b) / input.length;
	let part2 = Math.min.apply(
		null,
		[Math.floor(mean), Math.ceil(mean)].map(p =>
			input.reduce((accum, val) => {
				let d = Math.abs(val - p);
				return accum + ((d * d + d) >> 1);
			},
			0)
	));

	console.log(`part 1: ${part1}\npart 2: ${part2}`);
	console.timeEnd(TIMER);
})();
