class Grid
  attr_reader :r, :q

  def initialize
    @x = 0
    @y = 0
    @z = 0
  end

  def move(dir)
    case dir
    when 'n'
      @y += 1
      @z -= 1
    when 's'
      @y -= 1
      @z += 1
    when 'ne'
      @x += 1
      @z -= 1
    when 'sw'
      @x -= 1
      @z += 1
    when 'nw'
      @y += 1
      @x -= 1
    when 'se'
      @y -= 1
      @x += 1
    end
  end

  def distance
    ((0 - @x).abs + (0 - @y).abs + (0 - @z).abs) / 2
  end
end

grid = Grid.new
maxdist = 0
ARGF.read.strip.split(',').each do |dir|
  grid.move(dir)
  maxdist = [maxdist, grid.distance].max
end

puts "11a: #{grid.distance}"
puts "11b: #{maxdist}"