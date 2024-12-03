defmodule AOC2024.Day2 do
  def input do
    "inputs/day_2"
    |> File.stream!()
    |> parse_input()
  end

  def input(string) do
    string
    |> String.split("\n")
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> parse_input()
  end

  def parse_input(input) do
    input
    |> Stream.map(&String.split(&1))
    |> Stream.map(&Enum.map(&1, fn i -> String.to_integer(i) end))
    |> Enum.to_list()
  end

  def part1(data) do
    data
    |> Enum.map(fn report -> verify_report(report) end)
    |> Enum.count(&(&1 == :safe))
  end

  def part2(data) do
    data
    |> Enum.map(fn report -> soft_verify_report(report) end)
    |> Enum.count(&(&1 == :safe))
  end

  def soft_verify_report(report) when is_list(report) do
    direction = direction(report)

    if do_verify_report(report, direction) == :unsafe do
      Enum.map(0..(length(report) - 1), fn i ->
        List.delete_at(report, i)
      end)
      |> Enum.any?(fn report -> do_verify_report(report, direction) == :safe end)
      |> if do
        :safe
      else
        :unsafe
      end
    else
      :safe
    end
  end

  def verify_report(report) when is_list(report) do
    direction = direction(report)

    do_verify_report(report, direction)
  end

  def do_verify_report([_ | []], _direction), do: :safe

  def do_verify_report([a, b | rest] = _report, direction) do
    if verify_pair([a, b], direction) do
      do_verify_report([b | rest], direction)
    else
      :unsafe
    end
  end

  def do_verify_report(_, _), do: :unsafe

  def verify_pair([a, b], :increasing), do: within_distance?(a, b) and b > a
  def verify_pair([a, b], :decreasing), do: within_distance?(a, b) and a > b

  def direction(report) do
    Enum.reduce(tl(report), {0, 0, hd(report)}, fn b, {increasing, decreasing, a} ->
      cond do
        a > b -> {increasing, decreasing + 1, b}
        b > a -> {increasing + 1, decreasing, b}
        true -> {increasing, decreasing, b}
      end
    end)
    |> case do
      {increasing, decreasing, _} when increasing > decreasing -> :increasing
      _ -> :decreasing
    end
  end

  def within_distance?(a, b) do
    distance = abs(a - b)
    distance in 1..3
  end
end
