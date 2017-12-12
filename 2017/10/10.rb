require 'minitest/autorun'
require 'active_support/all'

class List
  attr_reader :arr, :pos, :skip

  def initialize(size)
    @arr = (0..(size-1)).to_a
    @pos = 0
    @skip = 0
  end

  def step(len)
    reverse(len)
    advance(len)
    increase_skip
  end

  def read(range)
    if range.end < arr.size
      arr[range]
    else
      arr[range.begin..-1] + arr[0..(range.end % arr.size)]
    end
  end

  def write(range, a)
    if range.end < arr.size
      arr[range] = a
    else
      lrange = range.begin..(arr.size-1)
      arr[lrange] = a[0..(lrange.size - 1)]
      rrange = 0..(range.end % arr.size)
      arr[rrange] = a[lrange.size..-1]
    end
  end

  def reverse(len)
    range = pos..(pos+len - 1)
    write(range, read(range).reverse)
  end

  def advance(len)
    @pos = (pos + len + skip) % arr.size
  end

  def increase_skip
    @skip += 1
  end
end

describe List do
  it 'reverses' do
    l = List.new(5)
    l.step(3)
    assert_equal [2, 1, 0, 3, 4], l.arr
  end

  it 'reverses 1' do
    l = List.new(5)
    l.step(1)
    l.step(1)
    l.step(1)
    l.step(1)
  end

  it 'wraps' do
    l = List.new(5)
    l.step(3)
    l.step(4)
    assert_equal [4, 3, 0, 1, 2], l.arr
  end
end

IN = "147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70"
l = List.new 256
input = IN.split(',').map(&:to_i)
input.each {|len| l.step(len) }
puts "10a: #{l.arr[0] * l.arr[1]}"

l = List.new 256
input = IN.chars.map(&:ord) + [17, 31, 73, 47, 23]

64.times do
  input.each {|len| l.step(len) }
end
sparse = l.arr
dense = sparse.in_groups_of(16).map do |group|
  group.reduce(&:^)
end
answer = dense.map {|i| i.to_s(16).rjust(2, '0') }.join
puts "10b: #{answer}"