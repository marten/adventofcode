import * as fs from 'node:fs'

export function debug<T>(x: T) {
  console.log(x)
  return x
}

export function readLines(filename: string) {
  const fileContent = fs.readFileSync(filename, 'utf-8')
  return fileContent.trim().split('\n')
}
