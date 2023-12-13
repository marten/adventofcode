import { expect, test } from "bun:test";
import { readFile } from "../helpers";
import { filter, findGears, numbers, parseInput, part1, part2 } from "./day03";

const SAMPLE_INPUT = `
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
`.trim();

test("solve sample input", () => {
  expect(part1(SAMPLE_INPUT)).toEqual(4361);
  expect(part2(SAMPLE_INPUT)).toEqual(467835);
});

test("solve actual input", () => {
  const input = readFile("03/day03.txt");
  expect(part1(input)).toEqual(551094);
  expect(part2(input)).toEqual(80179647);
});

test("filtering to only sample numbers", () => {
  const grid = filter(parseInput(SAMPLE_INPUT));
  // debugGrid(grid);
});

test("extracting numbers", () => {
  const result = numbers(parseInput(SAMPLE_INPUT));
  expect(result).toEqual([467, 114, 35, 633, 617, 58, 592, 755, 664, 598]);
});

test("extracting gears", () => {
  const result = findGears(parseInput(SAMPLE_INPUT));
  // console.dir(result, { depth: null });
  // expect(result).toEqual([{ coord: [3, 1], numbers: [{ coord: [0, 0] }] }]);
});
