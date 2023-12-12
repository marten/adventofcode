import fs from 'node:fs'

const filePath = '/Users/marten/dev/adventofcode/2023/1a.txt'
const fileContent = fs.readFileSync(filePath, 'utf-8')

const lines = fileContent.split('\n')
const numbers = lines
    .filter((line) => line !== '')
    .map((line) => extractNumber(line))
const sum = numbers.reduce((acc, curr) => acc + curr, 0)
console.log(sum)

function extractNumber(line: string): number {
    const digits = line.split('').filter((char) => isDigit(char))
    return parseInt(digits[0] + digits[digits.length - 1])
}

function isDigit(char: string): boolean {
    return /^\d$/.test(char)
}
