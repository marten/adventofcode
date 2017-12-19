class Counter
  def initialize str
    @str = str
  end

  def groups
    s = @str.dup
    score = 0
    multiplier = 0
    count = 0
    in_comment = false
    trash_count = 0

    while s.size > 0
      case s[0]
      when '{'
        if in_comment
          trash_count += 1
        else
          multiplier += 1
          count += 1
          score += multiplier
        end
        s = s[1..-1]
      when '}'
        if in_comment
          trash_count += 1
        else
          multiplier -= 1
        end
        s = s[1..-1]
      when '!'
        if in_comment
          s = s[2..-1]
        else
          s = s[1..-1]
        end
      when '<'
        if in_comment
          trash_count += 1
        end
        in_comment = true
        s = s[1..-1]
      when '>'
        in_comment = false
        s = s[1..-1]
      else
        if in_comment
          trash_count += 1
        end
        s = s[1..-1]
      end
    end

    [score, count, trash_count]
  end
end

require 'minitest/autorun'
describe Counter do
  def self.score(a, str)
    it(str) do
      assert_equal a, Counter.new(str).groups[0]
    end
  end

  def self.count(a, str)
    it(str) do
      assert_equal a, Counter.new(str).groups[1]
    end
  end

  def self.trash_count(a, str)
    it(str) do
      assert_equal a, Counter.new(str).groups[2]
    end
  end

  count 3, '{{},{}}'
  count 6, '{{{},{},{{}}}}'
  count 1, '{<{},{},{{}}>}'
  count 1, '{<a>,<a>,<a>,<a>}'
  count 5, '{{<a>},{<a>},{<a>},{<a>}}'
  count 2, '{{<!>},{<!>},{<!>},{<a>}}'

  count 0, '<>'
  count 0, '<random characters>'
  count 0, '<<<<>'
  count 0, '<{!>}{}>'
  count 0, '<!!>'
  count 0, '<!!!>>'
  count 0, '<{o"i!a,<{i<a>'

  score 9, '{{<!!>},{<!!>},{<!!>},{<!!>}}'

  trash_count 0, '<>'
  trash_count 17, '<random characters>'
  trash_count 3, '<<<<>'
  trash_count 2, '<{!>}>'
  trash_count 0, '<!!>'
  trash_count 0, '<!!!>'
  trash_count 10, '<{o"i!a,<{i<a>'
end

result = Counter.new(ARGF.read.strip).groups
puts "9a: #{result[0]}"
puts "9b: #{result[2]}"
