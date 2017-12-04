defmodule A do
  @moduledoc """
  Documentation for A
  """

  @doc """
  ## Examples

      iex> A.solve("1122")
      3

      iex> A.solve("1111")
      4

      iex> A.solve("1234")
      0

      iex> A.solve("91212129")
      9

  """

  def solve(a) do
    list = String.codepoints(a)
    head = List.first(list)
    solver(list ++ [head])
  end

  def solver([]) do
    0
  end

  def solver([a]) do
    0
  end

  def solver([a | [a|rest]]) do
    {value, _} = Integer.parse(a)
    value + solver([a|rest])
  end

  def solver([a | [b|rest]]) do
    0 + solver([b|rest])
  end

end
