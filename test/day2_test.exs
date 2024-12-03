defmodule AOC2024.Day2Test do
  use ExUnit.Case

  alias AOC2024.Day2

  describe "input/0" do
    test "exercise input" do
      assert [
               [48, 50, 51, 53, 55, 56, 59, 58],
               [12, 13, 14, 16, 17, 17] | _rest
             ] = Day2.input()
    end
  end

  describe "input/1" do
    test "provided example" do
      assert [
               [7, 6, 4, 2, 1],
               [1, 2, 7, 8, 9],
               [9, 7, 6, 2, 1],
               [1, 3, 2, 4, 5],
               [8, 6, 4, 4, 1],
               [1, 3, 6, 7, 9]
             ] = Day2.input(provided_example())
    end
  end

  describe "part/1" do
    test "provided example" do
      assert Day2.part1(Day2.input(provided_example())) == 2
    end

    test "provided input" do
      assert Day2.part1(Day2.input()) == 334
    end
  end

  describe "part/2" do
    test "provided example" do
      assert Day2.part2(Day2.input(provided_example())) == 4
    end

    test "provided input" do
      assert Day2.part2(Day2.input()) == 400
    end
  end

  describe "verify_report/1" do
    test "provided example" do
      assert Day2.verify_report([7, 6, 4, 2, 1]) == :safe
      assert Day2.verify_report([1, 2, 7, 8, 9]) == :unsafe
      assert Day2.verify_report([9, 7, 6, 2, 1]) == :unsafe
      assert Day2.verify_report([1, 3, 2, 4, 5]) == :unsafe
      assert Day2.verify_report([8, 6, 4, 4, 1]) == :unsafe
      assert Day2.verify_report([1, 3, 6, 7, 9]) == :safe
    end
  end

  describe "verify_report/2" do
    test "provided example" do
      assert Day2.soft_verify_report([7, 6, 4, 2, 1]) == :safe
      assert Day2.soft_verify_report([1, 2, 7, 8, 9]) == :unsafe
      assert Day2.soft_verify_report([9, 7, 6, 2, 1]) == :unsafe
      assert Day2.soft_verify_report([1, 3, 2, 4, 5]) == :safe
      assert Day2.soft_verify_report([8, 6, 4, 4, 1]) == :safe
      assert Day2.soft_verify_report([1, 3, 6, 7, 9]) == :safe
    end
  end

  describe "verify_pair/2" do
    test "increasing" do
      assert Day2.verify_pair([1, 2], :increasing) == true
      assert Day2.verify_pair([1, 1], :increasing) == false
      assert Day2.verify_pair([2, 1], :increasing) == false
    end

    test "decreasing" do
      assert Day2.verify_pair([2, 1], :decreasing) == true
      assert Day2.verify_pair([1, 1], :decreasing) == false
      assert Day2.verify_pair([1, 2], :decreasing) == false
    end

    test "within_distance" do
      assert Day2.within_distance?(1, 1) == false

      assert Day2.within_distance?(1, 2) == true
      assert Day2.within_distance?(1, 3) == true
      assert Day2.within_distance?(1, 4) == true
      assert Day2.within_distance?(1, 5) == false

      assert Day2.within_distance?(2, 1) == true
      assert Day2.within_distance?(3, 1) == true
      assert Day2.within_distance?(4, 1) == true
      assert Day2.within_distance?(5, 1) == false
    end
  end

  describe "direction/2" do
    test "increasing" do
      assert Day2.direction([1, 2, 3, 4, 5]) == :increasing
      assert Day2.direction([1, 3, 5, 7, 8]) == :increasing
      assert Day2.direction([2, 2, 3, 2, 4, 8]) == :increasing
    end

    test "decreasing" do
      assert Day2.direction([5, 4, 3, 2, 1]) == :decreasing
      assert Day2.direction([8, 7, 5, 3, 1]) == :decreasing
      assert Day2.direction([8, 4, 2, 3, 2, 2]) == :decreasing
    end
  end

  defp provided_example do
    ~S"""
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """
  end
end
