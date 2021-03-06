(() => {
	const TIMER = '2021/day1';
	console.time(TIMER);

	let part1 = 0, part2 = 0;
	let windows = [];
	$('pre').textContent
		.split(/\n/)
		.filter(s => s.length)
		.map(s => parseInt(s))
		.reduce((a,b) => {
			// part 1: count lines greater than previous
			part1 += +(b > a);

			// part 2: count sliding 3-element windows greater than previous
			windows.forEach((v, i) => windows[i] += b);
			windows.push(b);
			if (windows.length > 3) {
				part2 += +(windows[1] + b > windows[0]);
				windows.shift();
			}

			return b;
		},
		Number.MAX_SAFE_INTEGER);

	console.log(`part 1: ${part1}\npart 2: ${part2}`);
	console.timeEnd(TIMER);
})();
