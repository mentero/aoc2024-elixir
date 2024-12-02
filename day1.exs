defmodule Day1 do
  def input do
    "day_1_input"
    |> File.stream!()
    |> parse_input()
  end

  def input(string) do
    string
    |> String.split("\n")
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Day1.parse_input()
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

ExUnit.start()

defmodule Day1Test do
  use ExUnit.Case

  describe "input/0" do
    test "reads the file" do
      assert [[37033, 48086], [80098, 34930] | _rest] = Day1.input()
    end
  end

  describe("input/1") do
    test "parses the input" do
      assert [[3, 4], [4, 3], [2, 5], [1, 3], [3, 9], [3, 3]] = Day1.input(provided_example())
    end
  end

  describe "part1/0" do
    test "provided example" do
      example = Day1.input(provided_example())
      assert 11 = Day1.part1(example)
    end

    test "provided input" do
      assert 1_223_326 = Day1.input() |> Day1.part1()
    end
  end

  describe "part2/0" do
    test "provided example" do
      example = Day1.input(provided_example())
      assert 31 = Day1.part2(example)
    end

    test "provided input" do
      assert 21_070_419 = Day1.input() |> Day1.part2()
    end
  end

  defp provided_example do
    ~S"""
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    """
  end
end
