def abba(str)
  str.match(/(\w)(?!\1)(\w)\2\1/)
end

def split(str)
  supernets = []
  hypernets = []

  seq = ""
  str.each_char do |char|
    case char
    when '['
      supernets << seq
      seq = ""
    when ']'
      hypernets << seq
      seq = ""
    else
      seq << char
    end
  end

  supernets << seq

  [supernets, hypernets]
end

def tls(str)
  supernets, hypernets = split(str)
  supernets.any? { |a| abba(a) } && !hypernets.any?{ |a| abba(a) }

  # a, b, c = str.match(/(\w+)\[(\w+)\](\w+)/).captures
  # (abba(a) || abba(c)) && !abba(b)
end

def abas(str)
  chars = str.chars
  chars.zip(chars[1..-1]).zip(chars[2..-1]).map(&:flatten).select { |arr|
    arr[0] == arr[2] && arr[0] != arr[1]
  }.map { |arr| arr.join }
end

def bab(aba)
  "#{aba[1]}#{aba[0]}#{aba[1]}"
end

def ssl(str)
  supernets, hypernets = split(str)
  supernets.flat_map { |supernet| abas(supernet) }.select do |aba|
    hypernets.any? do |hypernet|
      hypernet.include?(bab(aba))
    end
  end.size > 0
end

input = File.readlines("7.txt")
puts "7a: ", input.select { |line| tls(line) }.size

puts "7b: ", input.select { |line| ssl(line) }.size

require 'minitest/autorun'

describe 'ssl' do
  it 'works' do
    assert ssl('aba[bab]xyz')
    refute ssl('xyx[xyx]xyx')
    assert ssl('aaa[kek]eke')
    assert ssl('zazbz[bzb]cdb')
  end

  it 'bab' do
    assert_equal 'bab', bab('aba')
  end

  it 'abas' do
    assert_equal ['aba'],        abas('aba')
    assert_equal ['aba'],        abas('abaq')
    assert_equal [],             abas('aaa')
    assert_equal ['aba', 'qwq'], abas('abaqwq')
    assert_equal ['aba', 'bab'], abas('abab')
  end
end

describe 'abba' do
  it 'works' do
    assert abba('abba')
    assert abba('jabbadabado')
    refute abba('foobar')
    refute abba('aaaa')
    refute abba('abbc')
  end

  it 'tls' do
    assert tls('abba[mnop]qrst')
    assert tls('zxcv[mnop]abba')
    refute tls('abcd[bddb]xyyx')
    refute tls('aaaa[qwer]tyui')
    assert tls('ioxxoj[asdfgh]zxcvbn')
  end
end
