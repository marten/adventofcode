defmodule Level3 do
  def input do
   File.read!("level3.txt")
   |> String.split("\n")
   |> Enum.map(fn(line) -> Regex.scan(~r/\d+/, line) |> List.flatten |> Enum.map(fn str -> String.to_integer(str) end) end)
  end

  def play(input) do
    input
    |> Enum.map(fn line -> Enum.sort(line) end)
    |> Enum.count(fn line -> (line[0] + line[1]) > line[2] end)
  end
end

IO.inspect(Level3.play(Level3.input))
