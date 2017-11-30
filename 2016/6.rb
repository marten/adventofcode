def a
  strings = ARGF.read
  cols = []

  strings.split("\n").each do |line|
    line.each_char.with_index do |char, idx|
      cols[idx] ||= {}
      cols[idx][char] ||= 0
      cols[idx][char] += 1
    end
  end

  answer = ""
  cols.each do |counts|
    puts counts.inspect
    char = counts.sort_by(&:last).first.first
    answer << char
  end

  puts answer
end

a
