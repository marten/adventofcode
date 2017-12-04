class Level1
  attr_reader :positions
  def initialize
    @dir = :north
    @x = 0
    @y = 0
    @positions = []
  end

  def play(cmds)
    cmds.each do |cmd|
      rotation = cmd[0]
      amount = cmd[1..-1].to_i

      rotate(rotation)

      while amount > 0
        move(1)
        amount -= 1

        if positions.include?(position)
          puts position.inspect
          puts distance.inspect
          return
        else
          positions << position
        end
      end
    end
  end

  def rotate(rotation)
    case rotation
    when 'L'
      left
    when 'R'
      right
    end
  end

  def left
    case @dir
    when :north then @dir = :west
    when :east  then @dir = :north
    when :south then @dir = :east
    when :west  then @dir = :south
    end
  end

  def right
    case @dir
    when :north then @dir = :east
    when :east  then @dir = :south
    when :south then @dir = :west
    when :west  then @dir = :north
    end
  end

  def move(amount)
    case @dir
    when :north then @y -= amount
    when :east  then @x += amount
    when :south then @y += amount
    when :west  then @x -= amount
    end
  end

  def position
    [@x, @y]
  end

  def distance
    @x + @y
  end
end




cmds = 'L3, R2, L5, R1, L1, L2, L2, R1, R5, R1, L1, L2, R2, R4, L4, L3, L3, R5, L1, R3, L5, L2, R4, L5, R4, R2, L2, L1, R1, L3, L3, R2, R1, L4, L1, L1, R4, R5, R1, L2, L1, R188, R4, L3, R54, L4, R4, R74, R2, L4, R185, R1, R3, R5, L2, L3, R1, L1, L3, R3, R2, L3, L4, R1, L3, L5, L2, R2, L1, R2, R1, L4, R5, R4, L5, L5, L4, R5, R4, L5, L3, R4, R1, L5, L4, L3, R5, L5, L2, L4, R4, R4, R2, L1, L3, L2, R5, R4, L5, R1, R2, R5, L2, R4, R5, L2, L3, R3, L4, R3, L2, R1, R4, L5, R1, L5, L3, R4, L2, L2, L5, L5, R5, R2, L5, R1, L3, L2, L2, R3, L3, L4, R2, R3, L1, R2, L5, L3, R4, L4, R4, R3, L3, R1, L3, R5, L5, R1, R5, R3, L1'.split(", ")

level = Level1.new
level.play(cmds)

