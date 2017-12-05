defmodule Five do
  def solve(_instructions, position) when position < 0, do: 0
  def solve(instructions, position) when position >= tuple_size(instructions), do: 0
  def solve(instructions, position) do
    next_position = position + elem(instructions, position)
    next_instructions = increment(instructions, position)
    1 + solve(next_instructions, next_position)
  end

  def increment(instructions, position) do
    val = elem(instructions, position)
    put_elem(instructions, position, next(val))
  end

  def next(x) do
    if x >= 3, do: x-1, else: x+1
  end
end

instructions = Enum.map(IO.stream(:stdio, :line), fn line ->
  line |> String.trim |> String.to_integer
end) |> List.to_tuple

IO.puts(Five.solve(List.to_tuple([0, 3, 0, 1, -3]), 0))
IO.puts(Five.solve(instructions, 0))