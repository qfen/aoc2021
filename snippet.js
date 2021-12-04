document.querySelectorAll("a > span.stats-both:first-child").forEach(el => {
	let el2 = el.nextElementSibling;
	let sum = parseInt(el.textContent) + parseInt(el2.textContent);
	el2.after(sum.toString().padStart(8,' '));
});
