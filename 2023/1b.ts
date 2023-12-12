import * as fs from 'node:fs'

const filePath = './1a.txt'
const fileContent = fs.readFileSync(filePath, 'utf-8')

const MATCHER = /(one|two|three|four|five|six|seven|eight|nine|\d)/g

export function solve(input: string) {
  return input
    .trim()
    .split(/\r?\n/)
    .map((line) => solveLine(line))
    .reduce((acc, curr) => acc + curr, 0)
}

console.log('Solution: ', solve(fileContent))

export function calibrationValues(lines: string[]) {
  return lines.map((line) => solveLine(line))
}

function solveLine(line: string) {
  const [a, b] = firstAndLastMatch(line)
  return a * 10 + b
}

function firstAndLastMatch(line: string): [number, number] {
  const numbers = matches(line)

  if (numbers.length == 0) {
    throw new Error('No numbers found in line: ' + line)
  } else if (numbers.length == 1) {
    return [numbers[0], numbers[0]]
  } else {
    return [numbers[0], numbers[numbers.length - 1]]
  }
}

export function matches(line: string): number[] {
  if (line.length === 0) {
    return [] as number[]
  }

  if (line.startsWith('one')) {
    return [1, ...matches(line.slice(1))]
  } else if (line.startsWith('two')) {
    return [2, ...matches(line.slice(1))]
  } else if (line.startsWith('three')) {
    return [3, ...matches(line.slice(1))]
  } else if (line.startsWith('four')) {
    return [4, ...matches(line.slice(1))]
  } else if (line.startsWith('five')) {
    return [5, ...matches(line.slice(1))]
  } else if (line.startsWith('six')) {
    return [6, ...matches(line.slice(1))]
  } else if (line.startsWith('seven')) {
    return [7, ...matches(line.slice(1))]
  } else if (line.startsWith('eight')) {
    return [8, ...matches(line.slice(1))]
  } else if (line.startsWith('nine')) {
    return [9, ...matches(line.slice(1))]
  } else if (line.startsWith('1')) {
    return [1, ...matches(line.slice(1))]
  } else if (line.startsWith('2')) {
    return [2, ...matches(line.slice(1))]
  } else if (line.startsWith('3')) {
    return [3, ...matches(line.slice(1))]
  } else if (line.startsWith('4')) {
    return [4, ...matches(line.slice(1))]
  } else if (line.startsWith('5')) {
    return [5, ...matches(line.slice(1))]
  } else if (line.startsWith('6')) {
    return [6, ...matches(line.slice(1))]
  } else if (line.startsWith('7')) {
    return [7, ...matches(line.slice(1))]
  } else if (line.startsWith('8')) {
    return [8, ...matches(line.slice(1))]
  } else if (line.startsWith('9')) {
    return [9, ...matches(line.slice(1))]
  } else {
    return matches(line.slice(1))
  }
}
