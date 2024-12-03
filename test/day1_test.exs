defmodule AOC2024.Day1Test do
  use ExUnit.Case

  alias AOC2024.Day1

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
