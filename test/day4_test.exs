defmodule AOC2024.Day4Test do
  use ExUnit.Case

  alias AOC2024.Day4

  describe "part1/1" do
    test "provided example" do
      example = provided_example()

      assert Day4.part1(example) == 18
    end

    test "input" do
      example =
        File.read!("inputs/day4")
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_charlist/1)

      assert Day4.part1(example) == 2547
    end
  end

  describe "part2/1" do
    test "provided example" do
      example = provided_example()

      assert Day4.part2(example) == 9
    end

    test "input" do
      example =
        File.read!("inputs/day4")
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_charlist/1)

      assert Day4.part2(example) == 1939
    end
  end

  defp provided_example do
    ~S"""
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end
end
