(() => {
	const TIMER = '2021/day5';
	console.time(TIMER);

	let autoArray = () => new Proxy([], {
		get: (arr, i) => (i in arr ? arr[i] : arr[i] = new Proxy([], {
			get: (arr, j) => (j in arr ? arr[j] : arr[j] = 0)
		}))
	});
	let part1 = autoArray(), part2 = autoArray();

	$('pre').textContent.trim().split("\n").forEach(s => {
		let x1, x2, y1, y2;
		[x1, y1, x2, y2] = Array.from(s.matchAll(/\d+/g), m => Number.parseInt(m[0]));

		let xdist = Math.abs(x2 - x1);
		let ydist = Math.abs(y2 - y1);
		let xdir = Math.sign(x2 - x1);
		let ydir = Math.sign(y2 - y1);
		let diag = xdir && ydir;
		if (diag && (xdist != ydist)) throw 'not snapped to 45 degrees';

		for (let i = 0; i < Math.max(xdist, ydist); i++) {
			let x = x1 + i * xdir;
			let y = y1 + i * ydir;
			if (!diag) part1[x][y]++;
			part2[x][y]++;
		}
	})

	console.log('part 1:', part1.flat().filter(n => n > 1).length,
		'part 2:', part2.flat().filter(n => n > 1).length);
	console.timeEnd(TIMER);
})();
