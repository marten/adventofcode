require 'rainbow'

Spiral = Enumerator.new do |out|
  out << [0, 0]
  out << [0, 1]

  row = -1
  col = 1
  len = 2

  out << [row, col]

  loop do
    len.times { col -= 1; out << [row, col] }
    len.times { row += 1; out << [row, col] }
    len += 1
    len.times { col += 1; out << [row, col] }
    len.times { row -= 1; out << [row, col] }
    len += 1
  end
end

class Grid
  attr_accessor :size

  def initialize(size)
    @size = size
    @rows = []

    for i in 0..(@size-1)
      @rows[i] = Array.new(@size, 0)
    end
  end

  def set(row, col, val)
    raise ArgumentError if row < 0
    raise ArgumentError if col < 0
    raise ArgumentError if row >= @size
    raise ArgumentError if col >= @size
    @rows[row][col] = val
  end

  def at(row, col)
    return 0 unless @rows[row]
    @rows[row][col] || 0
  end

  def neighbours(row, col)
    [at(row-1, col-1), at(row-1, col), at(row-1, col+1),
     at(row,   col-1),                 at(row,   col+1),
     at(row+1, col-1), at(row+1, col), at(row+1, col+1)]
  end

  def inspect(r, c)
    @rows.map.with_index do |row, ri|
      row.map.with_index do |cell, ci|
        if ri == r && ci == c
          Rainbow("#{cell}").color(:yellow)
        else
          "#{cell}"
        end
      end.join("\t")
    end.join("\n")
  end
end

grid = Grid.new(9)
grid.set(grid.size/2, grid.size/2, 1)
grid.set(grid.size/2, grid.size/2 + 1, 1)

Spiral.take(grid.size ** 2).each.with_index do |position, idx|
  next if idx <= 1
  row, col = position
  puts "="*100
  row = row + grid.size/2
  col = col + grid.size/2

  value = grid.neighbours(row, col).sum

  puts "Currently at row: #{row}, col: #{col}"
  puts "Neighbours: #{grid.neighbours(row, col).inspect}"
  puts "I will put #{value} into this cell"

  grid.set(row, col, value)
  puts grid.inspect(row, col)
  break if value > 325489
end
