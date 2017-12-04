lines = ARGF.readlines
differences = lines.map do |line|
  numbers = line.split(/\s+/).map(&:to_i).sort
  numbers[-1] - numbers[0]
end

puts "2a: #{differences.reduce(&:+)}"


divisors = lines.map do |line|
  numbers = line.split(/\s+/).map(&:to_i).sort
  numbers.permutation(2).map do |a, b|
    if a % b == 0
      a / b
    else
      0
    end
  end.reduce(&:+)
end

puts "2b: #{divisors.reduce(&:+)}"