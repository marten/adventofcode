import * as R from "remeda";
import { neighbours8 } from "../helpers";

type Grid = string[][];
type Coord = [number, number];

const NON_SYMBOLS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."];

export function part1(input: string) {
  const lines = parseInput(input);
  const filtered = filter(lines);
  const nums = numbers(filtered);
  return nums.reduce((a, b) => a + b, 0);
}

export function part2(input: string) {
  const lines = parseInput(input);
  const gears = findGears(lines);
  return R.pipe(
    gears,
    R.filter((gear) => gear.numbers.length === 2),
    R.map((gear) => gear.numbers.map((n) => n.value).reduce((a, b) => a * b)),
    (x) => x.reduce((a, b) => a + b, 0),
  );
}

export function filter(lines: Grid): Grid {
  return lines.map((line, y) => {
    return line.map((char, x) => {
      if (
        isDigit(char) &&
        connectedToSymbol(lines, leftMostDigit(lines, [x, y]))
      ) {
        return char;
      } else if (isSymbol(char)) {
        return char; // for debugging it can be useful to see the symbols
      } else {
        return ".";
      }
    });
  });
}

type Number = { coord: Coord; value: number };
type Gear = { coord: Coord; numbers: Number[] };

export function findGears(lines: Grid): Gear[] {
  return lines
    .flatMap((line, y) => {
      return line.map((char, x) => {
        if (isGear(char)) {
          return {
            coord: [x, y] as Coord,
            numbers: findAttachedNumbers(lines, [x, y]),
          };
        } else {
          return null;
        }
      });
    })
    .filter(Boolean);
}

function isGear(char: string | null | undefined) {
  return char === "*";
}

function findAttachedNumbers(lines: Grid, coord: Coord): Number[] {
  const [x, y] = coord;

  const n = neighbours8(x, y)
    .map(([x, y]) => {
      if (isDigit(lines[y]?.[x])) {
        const coord = leftMostDigit(lines, [x, y]);
        const value = valueAt(lines, coord);
        return { coord, value };
      }
    })
    .filter(Boolean);

  // return only unique numbers
  return R.uniqWith(
    n,
    (a, b) => a.coord[0] === b.coord[0] && a.coord[1] === b.coord[1],
  );
}

function valueAt(lines: Grid, coord: Coord) {
  const [x, y] = coord;
  return parseInt(lines[y].join("").slice(x));
}

export function numbers(lines: Grid) {
  return lines
    .flatMap((line) => line.join("").split(/[^\d]/))
    .filter(Boolean)
    .map(Number);
}

function leftMostDigit(lines: Grid, coord: Coord): Coord {
  const [x, y] = coord;

  if (isDigit(lines[y][x - 1])) {
    return leftMostDigit(lines, [x - 1, y]);
  } else {
    return [x, y];
  }
}

function connectedToSymbol(lines: Grid, coord: Coord) {
  const [x, y] = coord;

  if (neighbours8(x, y).some(([x, y]) => isSymbol(lines[y]?.[x]))) {
    return true;
  } else {
    if (isDigit(lines[y][x + 1])) {
      return connectedToSymbol(lines, [x + 1, y]);
    }
  }
}

function isDigit(char: string | null | undefined) {
  return char && char.match(/\d/);
}

function isSymbol(char: string | null | undefined) {
  return char && !NON_SYMBOLS.includes(char);
}

export function parseInput(input: string) {
  return input.split("\n").map((line) => line.split(""));
}

export function debugGrid(grid: Grid) {
  console.log(grid.map((line) => line.join("")).join("\n"));
}
