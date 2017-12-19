defmodule DayOneTest do
  use ExUnit.Case
  # doctest DayOne
  doctest A
  doctest B

  test "B solution" do
    {:ok, input} = File.read("input")
    input = String.strip(input)
    IO.inspect(B.solve(input))
  end
end
