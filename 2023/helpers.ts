import * as fs from "node:fs";

export function debug<T>(x: T) {
  console.log(x);
  return x;
}

export function readFile(filename: string) {
  const fileContent = fs.readFileSync(filename, "utf-8");
  return fileContent.trim();
}

export function readLines(filename: string) {
  return readFile(filename).split("\n");
}

export function neighbours8(x: number, y: number) {
  return [
    [x - 1, y - 1],
    [x, y - 1],
    [x + 1, y - 1],

    [x - 1, y],
    [x + 1, y],

    [x - 1, y + 1],
    [x, y + 1],
    [x + 1, y + 1],
  ];
}
