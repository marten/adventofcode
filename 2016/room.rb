require 'minitest/autorun'
require './decryptor'

class Room
  def initialize(str)
    @name, @sector, @checksum = str.scan(/(.+)-(\d+)\[(.+)\]/)[0]
  end

  def sector_id
    @sector.to_i
  end

  def decrypt
    Decryptor.shift(@name, sector_id)
  end

  def chars
    @name.gsub('-', '').split('')
  end

  def occurrences
    return @occurrences unless @occurrences.nil?

    @occurrences = {}

    chars.each do |char|
      occurrences[char] ||= 0
      occurrences[char] += 1
    end

    @occurrences
  end

  def five_most_common_letters
    occurrences.to_a.sort do |one, two|
      if one[1] != two[1]
        -1 * (one[1] <=> two[1])
      else
        (one[0] <=> two[0])
      end
    end[0..4].map(&:first)
  end

  def calculated_checksum
    chars.uniq.select {|letter| five_most_common_letters.include?(letter) }.sort do |a, b|
      if occurrences[a] != occurrences[b]
        -1 * (occurrences[a] <=> occurrences[b])
      else
        (a <=> b)
      end
    end.join('')
  end

  def real?
    calculated_checksum == @checksum
  end
end

class RoomTests < Minitest::Test
  def test_simple_room
    room = Room.new('aaaaa-bbb-z-y-x-123[abxyz]')
    assert room.real?
  end

  def test_all_same
    room = Room.new('a-b-c-d-e-f-g-h-987[abcde]')
    assert room.real?
  end

  def test_letter_order
    room = Room.new('not-a-real-room-404[oarel]')
    assert room.real?
  end

  def test_fake_room
    room = Room.new('totally-real-room-200[decoy]')
    refute room.real?
  end
end
