(() => {
	const TIMER = '2021/day3';
	console.time(TIMER);

	let lines = $('pre').textContent
		.split(/\n/)
		.filter(s => s.length)
		.map(s => s.split('').map(bit => parseInt(bit)));

	let sums = lines.reduce((accum, bits) => {
		bits.forEach((b, i) => accum[i] += b);
		return accum;
	},
	Array(lines[0].length).fill(0));

	let gamma = Number.parseInt(sums
		.map(count => +(count > lines.length / 2))
		.join(''),
	2);

	function filter_bits(fullArray, sum, invert = 0) {
		let numbers = fullArray;

		for (let i = 0; numbers.length > 1; i++) {
			if (i >= numbers[0].length) throw 'filter went wrong';

			let bit = invert ^ +(sum >= numbers.length / 2);
			numbers = numbers.filter(arr => arr[i] == bit);
			sum = numbers.reduce((accum, arr) => accum + arr[i + 1], 0);
		}

		return Number.parseInt(numbers[0].join(''), 2);
	}

	let oxy = filter_bits(lines, sums[0]);
	let co2 = filter_bits(lines, sums[0], 1);

	console.log(`part 1: ${gamma * (~gamma & 2**sums.length - 1)}\npart 2: ${oxy * co2}`);
	console.timeEnd(TIMER);
})();
