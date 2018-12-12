IO.stream(:stdio, :line)
|> Stream.map(fn str ->
  {n, ""} = str |> String.trim() |> Integer.parse()
  n
end)
|> Enum.sum()
|> IO.inspect()

#data = ARGF.readlines.map(&:to_i)
#data = [1, -2, 3, 1]

#puts "a: ", data.reduce(0, :+)
#puts "b: "
#x = data.reduce([0]) do |acc, i|
#  freq = acc.last + i

#  if acc.include?(freq)
#    break freq
#  else
#    acc << freq
#  end
#end
#puts x.inspect