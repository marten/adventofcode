
class Cpu
  attr_reader :registers

  def initialize
    @registers = Hash.new(0)
  end

  def inc(val)
    val
  end

  def dec(val)
    -val
  end

  def method_missing(name, *args)
    if args.size == 1
      puts "Increment #{name} by #{args[0]}"
      @registers[name] += args[0]
      @maxes ||= []
      @maxes << @registers.values.max
    elsif args.size == 0
      puts "Read #{name}, current value: #{@registers[name]}"
      @registers[name]
    end
  end

  def maxesmax
    @maxes.max
  end
end

source = ARGF.read
cpu = Cpu.new
cpu.instance_eval(source)
puts cpu.registers.values.max
puts cpu.maxesmax
