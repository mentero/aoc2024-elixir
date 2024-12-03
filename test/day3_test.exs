defmodule AOC2024.Day3Test do
  use ExUnit.Case

  alias AOC2024.Day3

  describe "part1/1" do
    test "example" do
      stream = Day3.input(provided_example())
      assert Day3.part1(stream) == 161
    end

    test "input" do
      stream = File.stream!("inputs/day_3", 1)
      assert Day3.part1(stream) == 179_571_322
    end
  end

  describe "part2/1" do
    test "example" do
      example = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      stream = Day3.input(example)
      assert Day3.part2(stream) == 48
    end

    test "input" do
      stream = File.stream!("inputs/day_3", 1)
      assert Day3.part2(stream) == 103_811_193
    end
  end

  defp provided_example do
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
  end
end
