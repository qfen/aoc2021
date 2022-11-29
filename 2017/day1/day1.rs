use std::io;

fn main() {
    let mut part1: u16 = 0;
    let mut part2: u16 = 0;

    let mut raw = String::new();
    io::stdin().read_line(&mut raw).unwrap();

    let input = raw.trim_end().as_bytes();
    let half = input.len() / 2;

    for (i, b) in input.iter().enumerate() {
        if *b == input[ (i + 1) % input.len() ] {
            part1 += (b - 48) as u16;
        }

        if *b == input[ (i + half) % input.len() ] {
            part2 += (b - 48) as u16;
        }
    }

    println!("part 1: {}", part1);
    println!("part 2: {}", part2);
}
