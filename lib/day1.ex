defmodule AOC2024.Day1 do
  def input do
    "inputs/day_1"
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
    |> Stream.map(fn
      [a, b] -> [String.to_integer(a), String.to_integer(b)]
      [] -> []
    end)
    |> Enum.to_list()
  end

  def part1(data) do
    data
    |> Enum.reduce({[], []}, fn [a, b], {list_a, list_b} -> {[a | list_a], [b | list_b]} end)
    |> then(fn {list_a, list_b} -> {Enum.sort(list_a), Enum.sort(list_b)} end)
    |> then(fn {list_a, list_b} -> Enum.zip(list_a, list_b) end)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part2(data) do
    {left_list, right_list} =
      data
      |> Enum.reduce({[], []}, fn [a, b], {list_a, list_b} -> {[a | list_a], [b | list_b]} end)
      |> then(fn {list_a, list_b} -> {Enum.reverse(list_a), Enum.reverse(list_b)} end)

    left_list
    |> Enum.map(fn x -> x * Enum.count(right_list, &(&1 == x)) end)
    |> Enum.sum()
  end
end
