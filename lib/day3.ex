defmodule AOC2024.Day3 do
  def input do
    "inputs/day_2"
    |> File.stream!(1)
  end

  def input(string) do
    {:ok, stream} = StringIO.open(string)
    IO.binstream(stream, 1)
  end

  @digits ~w(0 1 2 3 4 5 6 7 8 9)

  def part1(data) do
    data
    |> Stream.chunk_while(
      {},
      fn
        "m", {} ->
          {:cont, {"m"}}

        "u", {"m"} ->
          {:cont, {"mu"}}

        "l", {"mu"} ->
          {:cont, {"mul"}}

        "(", {"mul"} ->
          {:cont, {"mul("}}

        digit, {"mul("} when digit in @digits ->
          {:cont, {"mul(", digit}}

        new_digit, {"mul(", arg0} when new_digit in @digits and byte_size(arg0) < 3 ->
          {:cont, {"mul(", arg0 <> new_digit}}

        ",", {"mul(", arg0} ->
          {:cont, {"mul(", arg0, ","}}

        digit, {"mul(", arg0, ","} when digit in @digits ->
          {:cont, {"mul(", arg0, ",", digit}}

        new_digit, {"mul(", arg0, ",", arg1} when new_digit in @digits and byte_size(arg1) < 3 ->
          {:cont, {"mul(", arg0, ",", arg1 <> new_digit}}

        ")", {"mul(", arg0, ",", arg1} ->
          {:cont, {String.to_integer(arg0), String.to_integer(arg1)}, {}}

        _, _ ->
          {:cont, {}}
      end,
      fn {} -> {:cont, {}} end
    )
    |> Stream.map(fn {arg0, arg1} -> arg0 * arg1 end)
    |> Enum.sum()
  end
end
