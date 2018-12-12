inputs = IO.stream(:stdio, :line)
|> Stream.map(fn str ->
  {n, ""} = str |> String.trim() |> Integer.parse()
  n
end)


