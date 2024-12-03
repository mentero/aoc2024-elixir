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
      fn char, memory ->
        case parse_mul(char, memory) do
          {:cont, memory} -> {:cont, memory}
          {:ok, {arg0, arg1}} -> {:cont, {arg0, arg1}, {}}
        end
      end,
      fn {} -> {:cont, {}} end
    )
    |> Stream.map(fn {arg0, arg1} -> arg0 * arg1 end)
    |> Enum.sum()
  end

  def parse_mul("m", {}), do: {:cont, {"m"}}
  def parse_mul("u", {"m"}), do: {:cont, {"mu"}}
  def parse_mul("l", {"mu"}), do: {:cont, {"mul"}}
  def parse_mul("(", {"mul"}), do: {:cont, {"mul("}}
  def parse_mul(digit, {"mul("}) when digit in @digits, do: {:cont, {"mul(", digit}}

  def parse_mul(next_digit, {"mul(", arg0}) when next_digit in @digits and byte_size(arg0) < 3,
    do: {:cont, {"mul(", arg0 <> next_digit}}

  def parse_mul(",", {"mul(", arg0}), do: {:cont, {"mul(", arg0, ","}}

  def parse_mul(digit, {"mul(", arg0, ","}) when digit in @digits,
    do: {:cont, {"mul(", arg0, ",", digit}}

  def parse_mul(next_digit, {"mul(", arg0, ",", arg1})
      when next_digit in @digits and byte_size(arg1) < 3,
      do: {:cont, {"mul(", arg0, ",", arg1 <> next_digit}}

  def parse_mul(")", {"mul(", arg0, ",", arg1}),
    do: {:ok, {String.to_integer(arg0), String.to_integer(arg1)}}

  # Reset the memory on invalid match
  def parse_mul(_, _), do: {:cont, {}}

  def parse_do("d", {}), do: {:cont, {"d"}}
  def parse_do("o", {"d"}), do: {:cont, {"do"}}
  def parse_do("(", {"do"}), do: {:cont, {"do("}}
  def parse_do(")", {"do("}), do: :ok
  def parse_do(_, _), do: {:cont, {}}

  def parse_dont("d", {}), do: {:cont, {"d"}}
  def parse_dont("o", {"d"}), do: {:cont, {"do"}}
  def parse_dont("n", {"do"}), do: {:cont, {"don"}}
  def parse_dont("'", {"don"}), do: {:cont, {"don'"}}
  def parse_dont("t", {"don'"}), do: {:cont, {"don't"}}
  def parse_dont("(", {"don't"}), do: {:cont, {"don't("}}
  def parse_dont(")", {"don't("}), do: :ok
  def parse_dont(_, _), do: {:cont, {}}

  def part2(data) do
    data
    |> Stream.chunk_while(
      {true, {}, {}},
      fn
        char, {true, mul_memory, dont_memory} ->
          parsed_mul = parse_mul(char, mul_memory)
          parsed_dont = parse_dont(char, dont_memory)

          case {parsed_mul, parsed_dont} do
            {{:ok, {arg0, arg1}}, {:cont, _}} ->
              {:cont, {arg0, arg1}, {true, {}, {}}}

            {{:cont, _}, :ok} ->
              {:cont, {false, {}, {}}}

            _ ->
              {:cont, {true, elem(parsed_mul, 1), elem(parsed_dont, 1)}}
          end

        char, {false, {}, do_memory} ->
          case parse_do(char, do_memory) do
            {:cont, memory} -> {:cont, {false, {}, memory}}
            :ok -> {:cont, {true, {}, {}}}
          end
      end,
      fn _ -> {:cont, nil} end
    )
    |> Stream.map(fn {arg0, arg1} -> arg0 * arg1 end)
    |> Enum.sum()
  end
end
