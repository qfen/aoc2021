(() => {
	const TIMER = '2021/day8';
	console.time(TIMER);

	let str_intersect = (a, b) => a.split('').filter(c => b.indexOf(c) > -1).length;
	let str_sort = s => s.split('').sort().join('');

	let decode = s => {
		let byLength = s.split(' ')
			.sort((a, b) => a.length - b.length)
			.map(s => str_sort(s));

		let result = [];
		result[1] = byLength[0]; // 1: two segments
		result[7] = byLength[1]; // 7: three segments
		result[4] = byLength[2]; // 4: four segments

		let lenFive = byLength.slice(3, 6); // 2 3 5: (five segments)
		let lenSix = byLength.slice(6, 9); // 0 6 9: (six segments)

		result[8] = byLength[9]; // 8: seven segments

		result[3] = lenFive.splice(lenFive.findIndex(e => str_intersect(e, result[1]) == 2), 1)[0];

		result[9] = lenSix.splice(lenSix.findIndex(e => str_intersect(e, result[4]) == 4), 1)[0];

		if (str_intersect(result[4], lenFive[0]) == 3) lenFive.reverse();
		result[2] = lenFive[0];
		result[5] = lenFive[1];

		if (str_intersect(result[1], lenSix[0]) == 1) lenSix.reverse();
		result[0] = lenSix[0];
		result[6] = lenSix[1];

		return new Map(Array.from(result.keys()).map(i => [result[i], i]));
	}

	let part1 = 0, part2 = 0;
	$('pre').textContent
		.trim()
		.split('\n')
		.forEach(line => {
			let digits, result;
			[digits, result] = line.split(' | ');
			let key = decode(digits);

			part2 += result.split(' ').reduce((accum, group) => {
				let digit = key.get(str_sort(group));
				if ([1, 4, 7, 8].indexOf(digit) > -1) part1++;
				return 10 * accum + digit;
			},
			0);
		});

	console.log(`part 1: ${part1}\npart 2: ${part2}`);
	console.timeEnd(TIMER);
})();
