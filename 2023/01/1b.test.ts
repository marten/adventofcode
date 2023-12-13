import { expect, test } from 'bun:test'
import { calibrationValues, matches, solve } from './1b'

const SAMPLE_INPUT = `two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen`

test('runs against sample', () => {
  expect(solve(SAMPLE_INPUT)).toEqual(281)
})

test('calibrationValues', () => {
  expect(calibrationValues(SAMPLE_INPUT.split('\n'))).toEqual([
    29, 83, 13, 24, 42, 14, 76,
  ])
})

test('matches', () => {
  expect(matches('two1nine')).toEqual([2, 1, 9])
  expect(matches('9h1xcrcggtwo38')).toEqual([9, 1, 2, 3, 8])
  expect(matches('hd3')).toEqual([3])
})
