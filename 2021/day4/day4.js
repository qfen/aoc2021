(() => {
	const TIMER = '2021/day4';
	console.time(TIMER);

	let blocks = $('pre').textContent.split(/\n{2,}/);
	let seq = blocks.shift().split(',').map(s => Number.parseInt(s));
	let firstWin = seq.length, lastWin = 0, part1, part2;
	blocks.map(block => {
		let board = block.split(/\s*\n/).map(line =>
			line.split(/\s+/).filter(s => s.length).map(s => Number.parseInt(s))
		);
		return {board: board, sum: board.flat().reduce((a,b) => a + b)};
	}).forEach(e => {
		let row, col, index;
		let rowTrack = Array(5).fill(0), colTrack = Array(5).fill(0);

		OUTER: for (index = 0; index < seq.length; index++) {
			for (row = 0; row < e.board.length; row++) {
				if ((col = e.board[row].indexOf(seq[index])) > -1) {
					e.sum -= seq[index];
					if (++rowTrack[row] == 5 || ++colTrack[col] == 5) break OUTER;
				}
			}
		}

		if (index < firstWin) [firstWin, part1] = [index, e.sum * seq[index]];
		if (index > lastWin) [lastWin, part2] = [index, e.sum * seq[index]];
	});

	console.log(`part 1: ${part1}\npart 2: ${part2}`);
	console.timeEnd(timer);
})();
