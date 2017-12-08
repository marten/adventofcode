require 'minitest/autorun'

class Instruction < Struct.new(:register_to_modify, :operation, :amount, :register_to_test, :conditional, :test_value)
  def self.parse(str)
    match = str.match(/(\w+) (inc|dec) (-?\d+) if (\w+) (>|<|<=|>=|==|!=) (-?\d+)/)

    new(match[1],
        match[2],
        match[3].to_i,
        match[4],
        match[5],
        match[6].to_i)
  end
end

describe Instruction do
  it 'parses' do
    instruction = Instruction.parse("b inc 5 if a > 1")
    assert_equal "b", instruction.register_to_modify
    assert_equal "inc", instruction.operation
    assert_equal 5, instruction.amount
    assert_equal "a", instruction.register_to_test
    assert_equal ">", instruction.conditional
    assert_equal 1, instruction.test_value
  end
end

class Cpu
  attr_reader :registers

  def initialize
    @registers = Hash.new(0)
  end

  def run(instruction)
    if check_conditional(instruction)
      modify_registers(instruction)
    end
  end

  def check_conditional(instruction)
    lhs = get(instruction.register_to_test)
    rhs = instruction.test_value
    lhs.send(instruction.conditional, rhs)
  end

  def modify_registers(instruction)
    case instruction.operation
    when "inc"
      registers[instruction.register_to_modify] += instruction.amount
    when "dec"
      registers[instruction.register_to_modify] -= instruction.amount
    end
  end

  def get(key)
    registers[key]
  end

  def max_register_value
    registers.values.max
  end
end

describe Cpu do
  it 'runs instructions' do
    cpu = Cpu.new
    cpu.run(Instruction.new('b', 'inc', 5, 'a', '>', 1))
    cpu.run(Instruction.new('a', 'inc', 1, 'b', '<', 5))
    cpu.run(Instruction.new('c', 'dec', -10, 'a', '>=', 1))
    cpu.run(Instruction.new('c', 'inc', -20, 'c', '==', 10))
    assert_equal 1, cpu.get("a")
  end
end

instructions = ARGF.readlines.map { |line| Instruction.parse(line) }
cpu = Cpu.new
max = 0
instructions.each { |i| cpu.run(i); max = [cpu.max_register_value, max].max }
puts "A: #{cpu.max_register_value}"
puts "B: #{max}"
