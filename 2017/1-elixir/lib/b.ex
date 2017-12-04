defmodule B do
  @moduledoc """
  Documentation for B.
  """

  @doc """
  iex> B.solve("1212")
  6

  iex> B.solve("1221")
  0

  iex> B.solve("123425")
  4

  iex> B.solve("123123")
  12

  iex> B.solve("12131415")
  4
  """
  def solve(str) do
    list = str |> String.codepoints |> convert
    solver(list)
  end

  @doc """
  iex> B.convert([1,2,3,4,5,6])
  [{ 1,4 },{ 2,5 },{ 3,6 },{ 4, 1 }, { 5, 2 }, { 6, 3 }]
  """
  def convert(list) do
    len = Enum.count(list)
    {a, b} = Enum.split(list, round(len / 2))

    Enum.zip([a, b]) ++ Enum.zip([b, a])
  end

  def solver([]) do
    0
  end

  def solver([{a, a} |rest]) do
    {value, _} = Integer.parse(a)
    value + solver(rest)
  end

  def solver([{a, _} | rest]) do
    0 + solver(rest)
  end

end
