screen = []

for x in 0..49
  for y in 0..5
    screen[y] ||= []
    screen[y][x] = '.'
  end
end

def rect(screen, args)
  x, y = args.split("x").map(&:to_i)

  for row in 0..(y-1)
    for col in 0..(x-1)
      screen[row][col] = '#'
    end
  end
  screen
end

def shift(arr, by)
  arr[-by..-1] + arr[0..-(by+1)]
end

require 'minitest/autorun'

describe 'shift' do
  it 'foo' do
    assert_equal [3, 1, 2], shift([1, 2, 3], 1)
    assert_equal '......#...........................................', shift('#.................................................', 6)
  end
end

def rotate_row(screen, y, by)
  shifted = shift(screen[y], by)
  screen[y] = shifted
  screen
end

def rotate_column(screen, x, by)
  column = screen.map { |row| row[x] }
  shifted = shift(column, by)
  shifted.each_with_index { |char, idx| screen[idx][x] = char }
  screen
end

def rotate(screen, arg)
  style, idx, by = arg.match(/(\w+) \w=(\d+) by (\d+)/).captures

  case style
  when 'row'
    rotate_row(screen, idx.to_i, by.to_i)
  when 'column'
    rotate_column(screen, idx.to_i, by.to_i)
  else
    screen
  end
end

def printscreen(screen)
  for line in screen
    line.each_with_index do |char, idx|
      print "\t" if idx % 5 == 0
      print char
    end
    print "\n"
  end
end

instructions = File.readlines('8.txt')

for instruction in instructions
  op, *args = instruction.split(' ')
  case op
  when 'rect'
    screen = rect(screen, args.join(' '))
  when 'rotate'
    screen = rotate(screen, args.join(' '))
  end

  puts instruction
  printscreen(screen)
  puts
end

count = 0
for line in screen
  for char in line
    if char == '#'
      count += 1
    end
  end
end

puts
puts count
