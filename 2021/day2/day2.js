(() => {
	const TIMER = '2021/day2';
	console.time(TIMER);

	let part1 = 0, part2 = 0, forward = 0;

	for (const line of $('pre').textContent.matchAll(/^(\w+)\s+(\d+)$/gm)) {
		let dist = Number.parseInt(line[2]);
		switch (line[1]) {
			case 'forward':
				forward += dist;
				part2 += dist * part1;
				break;
			case 'up':
				part1 -= dist;
				break;
			case 'down':
				part1 += dist;
				break;
			default:
				throw `Unknown direction ${line[1]}`;
		}
	}

	console.log(`part 1: ${part1 * forward}\npart 2: ${part2 * forward}`);
	console.timeEnd(TIMER);
})();
