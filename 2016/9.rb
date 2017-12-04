require 'minitest/autorun'

def expand(str)
  if match = str.match(/\((\d+)x(\d+)\)/)
    len, repeats = match.captures.map(&:to_i)
    match.pre_match +
      match.post_match[0..(len-1)] * repeats +
      expand(match.post_match[len..-1])
  else
    str
  end
end

describe 'expand' do
  it 'does nothing if there are no markers' do
    assert_equal 'ADVENT', expand('ADVENT')
  end

  it 'expands one repetition' do
    assert_equal 'ABBBBBC', expand('A(1x5)BC')
  end

  it 'does not expand repetitions inside repetition' do
    assert_equal 'A(1x5)(1x5)C', expand('A(5x2)(1x5)C')
  end

  it 'expands more than one repetition' do
    assert_equal 'ABBBCDDDE', expand('A(1x3)BC(1x3)DE')
  end

  it 'given tests' do
    assert_equal 'XYZXYZXYZ', expand('(3x3)XYZ')
    assert_equal 'ABCBCDEFEFG', expand('A(2x2)BCD(2x2)EFG')
    assert_equal '(1x3)A', expand('(6x1)(1x3)A')
    assert_equal 'X(3x3)ABC(3x3)ABCY', expand('X(8x2)(3x3)ABCY')
  end
end

ARGF.readlines.each do |line|
  puts line.strip.size
  puts expand(line.strip).size
end
