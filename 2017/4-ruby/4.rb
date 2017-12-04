def valid?(str)
  words = str.split.map { |word| word.chars.sort.join }
  ! words.uniq!
end

puts ARGF.readlines.select { |line| valid?(line) }.size
