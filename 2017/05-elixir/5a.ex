defmodule Five do
  def solve(_instructions, position) when position < 0, do: 0
  def solve(instructions, position) when position >= length(instructions), do: 0
  def solve(instructions, position) do
    next_position = position + Enum.at(instructions, position)
    next_instructions = increment(instructions, position)
    1 + solve(next_instructions, next_position)
  end

  def increment(instructions, position) do
    List.update_at(instructions, position, &(&1 + 1))
  end
end

instructions = Enum.map(IO.stream(:stdio, :line), fn line ->
  line |> String.trim |> String.to_integer
end)

IO.puts(Five.solve(instructions, 0))