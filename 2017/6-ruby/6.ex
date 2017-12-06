defmodule Six do
  def solve(state, history) do
    IO.inspect(state)
    if MapSet.member?(history, state) do
      0
    else
      next_state = next(state)
      next_history = MapSet.put(history, state)
      1 + solve(next_state, next_history)
    end
  end

  def next(state) do
    max = Enum.max(state)
    idx = Enum.find_index(state, &(&1 == max))
    indices = Enum.map(1..max, &(Integer.mod(idx+&1, length(state))))

    state
    |> List.replace_at(idx, 0)
    |> add(indices)
  end

  def add(state, []), do: state
  def add(state, [idx | rest]) do
    state
    |> List.update_at(idx, &(&1+1))
    |> add(rest)
  end
end

state = [0,2,7,0]
IO.puts Six.solve([4, 1, 15, 12, 0, 9, 9, 5, 5, 8, 7, 3, 14, 5, 12, 3], MapSet.new)

# puts "Iterations needed: #{states.size}"
# puts "Loop size: #{states.size - history.index(state)}"
