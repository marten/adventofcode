require 'rainbow'

Spiral = Enumerator.new do |out|
  out << [0, 0]
  out << [0, 1]

  row = -1
  col = 1

  out << [row, col]

  len = 2

  loop do
    len.times do
      col = col-1
      out << [row, col]
    end

    len.times do
      row = row+1
      out << [row, col]
    end

    len += 1

    len.times do
      col = col+1
      out << [row, col]
    end

    len.times do
      row = row-1
      out << [row, col]
    end

    len += 1
  end
end

class Grid
  attr_accessor :row, :col, :size

  def initialize(size)
    @size = size
    @rows = []
    @row = 0
    @col = 0

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

  def nextval
    neighbours(@row, @col).sum
  end

  def neighbours(row, col)
    [at(row-1, col-1), at(row-1, col), at(row-1, col+1),
     at(row,   col-1),                 at(row,   col+1),
     at(row+1, col-1), at(row+1, col), at(row+1, col+1)]
  end

  def find_next_cell
    tx = @row - (@size/2)
    ty = @col - (@size/2)

    case
    when tx > 0 && tx > ty.abs
      puts 'move up'
      [@row - 1, @col] # move up
    when ty > 0 && ty >= tx.abs
      puts 'move right'
      [@row, @col + 1] # move right
    when tx < 0 && tx <= ty
      puts 'move down'
      [@row+1, @col] # move down
    else
      puts 'move left'
      [@row, @col-1] # move left
    end
  end

  def inspect
    @rows.map.with_index do |row, ri|
      row.map.with_index do |cell, ci|
        if ri == @row && ci == @col
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
  grid.row = row + grid.size/2
  grid.col = col + grid.size/2

  value = grid.neighbours(grid.row, grid.col).sum

  puts "Currently at row: #{grid.row}, col: #{grid.col}"
  puts "Neighbours: #{grid.neighbours(grid.row, grid.col).inspect}"
  puts "I will put #{value} into this cell"

  grid.set(grid.row, grid.col, grid.nextval)
  puts grid.inspect
  break if value > 325489
end
