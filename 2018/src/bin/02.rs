extern crate itertools;

use itertools::Itertools;
use std::collections::HashMap;

fn char_counts(string: &str) -> HashMap<char, i32> {
    let mut counts = HashMap::new();

    for ch in string.chars() {
        let count = counts.entry(ch).or_insert(0);
        *count += 1;
    }

    counts
}

#[test]
fn test_char_counts() {
    let mut hash_map = HashMap::new();
    hash_map.insert('a', 1);
    hash_map.insert('b', 1);
    hash_map.insert('c', 1);
    assert_eq!(char_counts("abc"), hash_map);

    let mut hash_map = HashMap::new();
    hash_map.insert('a', 2);
    hash_map.insert('b', 3);
    hash_map.insert('c', 1);

    assert_eq!(char_counts("ababcb"), hash_map);
}

fn repeats(box_id: &str, amount: i32) -> bool {
    let counts = char_counts(box_id);
    counts.values().any(|&x| x == amount)
}

#[test]
fn test_repeats() {
    assert_eq!(repeats("abcdef", 2), false);
    assert_eq!(repeats("abcdef", 3), false);
    assert_eq!(repeats("bababc", 2), true);
    assert_eq!(repeats("bababc", 3), true);
}

fn part1(input: &str) -> i32 {
    let mut twice = 0;
    let mut thrice = 0;

    let lines = input.split('\n');
    for l in lines {
        if repeats(l, 2) { twice += 1; }
        if repeats(l, 3) { thrice += 1; }
    }

    twice * thrice
}

#[test]
fn part1example() {
    assert_eq!(part1("abcdef\n bababc\n abbcde\n abcccd\n aabcdd\n abcdee\n ababab"), 12);
}

fn distance(a: &str, b: &str) -> usize {
    a.len() - a.chars().zip(b.chars()).into_iter().filter(|(x, y)| x == y ).count()
}

#[test]
fn test_distance() {
    assert_eq!(distance("asdf", "asdf"), 0);
    assert_eq!(distance("abcde", "axcye"), 2);
    assert_eq!(distance("fghij", "fguij"), 1);
}

fn part2(input: &str) -> String {
    let mut best = (usize::max_value(), "", "");

    for a in input.split('\n') {
        for b in input.split('\n') {
            let dist = distance(a, b);
            if dist > 0 && dist < best.0 {
                best = (dist, a, b);
            }
        }
    }

    println!("{}", best.0);
    println!("{}", best.1);
    println!("{}", best.2);

    let a = best.1;
    let b = best.2;
    let overlap: Vec<String> = a.chars().zip(b.chars()).into_iter().filter(|(x, y)| x == y ).map(|(x, y)| x.to_string()).collect();
    overlap.join("").to_string()
}

#[test]
fn part2example() {
    assert_eq!(part2("abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz"), "fgij");
}

fn main() {
    aoc::main(part1, part2);
}
