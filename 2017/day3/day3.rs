use std::io;

fn main() {
    let mut raw = String::new();
    io::stdin().read_line(&mut raw).unwrap();
    let n: i32 = raw.trim().parse().expect("weird input");

    let s = (n as f64).sqrt().ceil() as i32;
    let r = s / 2;
    let q = s & 0x1;
    let h = -2*q + 1; // -1: 'west' or 'south'; 1: 'east' or 'north'
    let c = s*s - 2*r + (1 - q);
    let o = n - c;
    let x: i32;
    let y: i32;

    if o < 0 { // 'east' or 'west' quadrants
        x = h * r;
        y = h * (o + r);
    } else { // 'north' or 'south' quadrants
        x = -h * o + h * r;
        y = h * r;
    }

    let part1 = x.abs() + y.abs();

    println!("part 1: ({}, {}) -> {}", x, y, part1);
}
