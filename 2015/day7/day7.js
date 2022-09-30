(() => {
	const TIMER = '2015/day7';
	console.time(TIMER);

	let ops = new Map($('pre').textContent.trim().split('\n').map(line => {
		let string, wire;
		[string, wire] = line.split(' -> ');
		return [wire, [string]];
	}));

	let desc = (sym, n) => {
		let result = ops.get(sym);
		if (result[1].length == 2) {
			console.log(result[1][1].toString().padStart(n, ' '));
		} else if (/^\d+$/.test(result[1][0])) {
			result[1][1] = Number.parseInt(result[1][0]);
			console.log(result[1][1].toString().padStart(n, ' '));
		} else {
			console.log(`recurse into ${result[1][0]}`.padStart(n, ' '));
		}
	}

	desc('a', 0);

	console.timeEnd(TIMER);
})();
