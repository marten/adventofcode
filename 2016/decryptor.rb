require 'minitest/autorun'

class Decryptor
  def self.shift(string, times)
    string.split('-').map {|str| shift_one(str, times) }.join('-')
  end

  def self.shift_one(string, times)
    base = 'a'.codepoints[0]
    string.codepoints.map { |i| ((i - base + times) % 26) + base  }.pack("U*")
  end
end

describe Decryptor do
  it 'shifts letters' do
    Decryptor.shift('a', 1).must_equal 'b'
  end
  it 'rotates letters' do
    Decryptor.shift('a', 27).must_equal 'b'
  end
end
