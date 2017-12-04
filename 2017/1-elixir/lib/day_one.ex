defmodule DayOne do
  @moduledoc """
  Documentation for DayOne.
  """

  @doc """
  ## Examples

      iex> DayOne.solve("1122")
      3

      iex> DayOne.solve("1111")
      4

      iex> DayOne.solve("1234")
      0

      iex> DayOne.solve("91212129")
      9

  """

  def solve(a) do
    list = String.codepoints(a)
    head = List.first(list)
    solver(list ++ [head])
  end

  @doc """
  iex> DayOne.solve_b("1212")
  6

  iex> DayOne.solve_b("1221")
  0

  iex> DayOne.solve_b("123425")
  4

  iex> DayOne.solve_b("123123")
  12

  iex> DayOne.solve_b("12131415")
  4
  """
  def solve_b(str) do
    # len = String.length(str)
    # {a, b} = String.split_at(len / 2)

    # list = [String.codepoints(a),
    #         String.codepoints(b)] |> Enum.zip
    # head = List.first(list)
    # solver(list ++ [head])
  end

  @doc """
  iex> DayOne.convert([1,2,3,4,5,6])
  [1,4,2,5,3,6,4]
  """

  def convert(list) do

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
