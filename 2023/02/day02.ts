import { readFile } from '../helpers'

type Reveal = {
  red: number
  green: number
  blue: number
}

type Bag = {
  red: number
  green: number
  blue: number
}

type Game = {
  id: number
  reveals: Reveal[]
}

function parseInput(input: string): Game[] {
  return input.split('\n').map((line) => {
    const preparse = line.match(/^Game (\d+): (.*)$/)

    const reveals = preparse[2].split(';').map((reveal) => {
      const red = reveal.match(/(\d+) red/)
      const green = reveal.match(/(\d+) green/)
      const blue = reveal.match(/(\d+) blue/)

      return {
        red: (red && red.length == 2 && parseInt(red[1])) || 0,
        green: (green && green.length == 2 && parseInt(green[1])) || 0,
        blue: (blue && blue.length == 2 && parseInt(blue[1])) || 0,
      }
    })

    return { id: parseInt(preparse[1]), reveals }
  })
}

function validReveal(reveal: Reveal, bag: Bag) {
  return (
    reveal.red <= bag.red &&
    reveal.green <= bag.green &&
    reveal.blue <= bag.blue
  )
}

function validGame(game: Game, bag: Bag) {
  return game.reveals.every((reveal) => validReveal(reveal, bag))
}

function minimumBag(game: Game) {
  return game.reveals.reduce(
    (acc, curr) => ({
      red: Math.max(acc.red, curr.red),
      green: Math.max(acc.green, curr.green),
      blue: Math.max(acc.blue, curr.blue),
    }),
    { red: 0, green: 0, blue: 0 }
  )
}

function power(bag: Bag) {
  return bag.red * bag.green * bag.blue
}

export function part1(input: string) {
  const games = parseInput(input)
  const bag = { red: 12, green: 13, blue: 14 }
  const validGames = games.filter((game) => validGame(game, bag))
  return validGames.map((game) => game.id).reduce((acc, curr) => acc + curr, 0)
}

export function part2(input: string) {
  const games = parseInput(input)
  const minimumBags = games.map(minimumBag)
  const powers = minimumBags.map(power)

  return powers.reduce((acc, curr) => acc + curr, 0)
}

const input = readFile('02/day02.txt')
console.log('Solution part 1: ', part1(input))
console.log('Solution part 2: ', part2(input))
