extern crate aoc;
extern crate regex;

use std::collections::HashMap;
use std::str::FromStr;
use aoc::geom::{Point, Rect};

struct Claim {
    id: i32,
    rect: Rect
}

trait ParsingCaptures {
    fn parse<T: FromStr>(&self, group: &str) -> Result<T, <T as FromStr>::Err>;
}

impl<'a> ParsingCaptures for regex::Captures<'a> {
    fn parse<T: FromStr>(&self, group: &str) -> Result<T, <T as FromStr>::Err> {
        self.name(group).unwrap().as_str().parse::<T>()
    }
}

fn claims(input: &str) -> Vec<Claim> {
    let re = regex::Regex::new(r"#(?P<id>\d+) @ (?P<x>\d+),(?P<y>\d+): (?P<w>\d+)x(?P<h>\d+)").unwrap();
    input.lines().map(|line| {
        let captures = re.captures(line).unwrap();
        let x = captures.parse::<i32>("x").unwrap();
        let y = captures.parse::<i32>("y").unwrap();
        let w = captures.parse::<i32>("w").unwrap();
        let h = captures.parse::<i32>("h").unwrap();
        let rect = Rect::from_inclusive_ranges(x..=x+w-1, y..=y+h-1);

        Claim {
            id: captures.parse::<i32>("id").unwrap(),
            rect: rect
        }
    }).collect()
}

fn part1(input: &str) -> usize {
    let mut fabric = HashMap::new();

    for claim in claims(input) {
        for point in claim.rect.iter() {
            *fabric.entry(point).or_insert(0) += 1;
        }
    }

    fabric.iter().fold(0, |acc, (_k,&v)| if v > 1 { acc + 1 } else { acc })
}

#[test]
fn part1example() {
    assert_eq!(part1("#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2"), 4);
}

fn part2(input: &str) -> i32 {
    let c = claims(input);

    c.iter()
        .filter(|claim| {
            ! c.iter().any(|other| claim.id != other.id && other.rect.overlaps_with(claim.rect.clone()))
        })
        .nth(0)
        .unwrap()
        .id
}

#[test]
fn part2example() {
    assert_eq!(part2("#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2"), 3);
}

fn main() {
    aoc::main(part1, part2);
}
