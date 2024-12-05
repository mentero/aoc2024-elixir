defmodule AOC2024.Day4 do
  def file_input do
  end

  @type input_t :: list(list(char()))

  # I have labeled axes wrong XD
  # x should be y and y should be x
  # But I am too lazy to fix it now
  @spec part1(input_t()) :: integer()
  def part1(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(_overall = 0, fn {row, x}, overall ->
      row_sum =
        row
        |> Enum.with_index()
        |> Enum.reduce(_row_sum = 0, fn
          {?X, y}, row_sum -> row_sum + find_xmas(input, x, y)
          _, row_sum -> row_sum
        end)

      overall + row_sum
    end)
  end

  defp find_xmas(input, x, y) do
    [
      find_forward(input, x, y),
      find_reversed(input, x, y),
      find_vertical(input, x, y),
      find_vertical_reversed(input, x, y),
      find_diagonal_right(input, x, y),
      find_diagonal_left(input, x, y),
      find_diagonal_reversed_right(input, x, y),
      find_diagonal_reversed_left(input, x, y)
    ]
    |> Enum.count(&(&1 == true))
  end

  defp find_forward(input, x, y) do
    Enum.at(input, x) |> Enum.slice(y..(y + 3)) == ~c"XMAS"
  end

  defp find_reversed(input, x, y) do
    Enum.at(input, x) |> Enum.slice((y - 3)..y) == ~c"SAMX"
  end

  defp find_vertical(input, x, y) do
    starting_row = Enum.at(input, x)

    if x + 3 < Enum.count(input) do
      ~c"XMAS" == [
        input |> Enum.at(x) |> Enum.at(y),
        input |> Enum.at(x + 1) |> Enum.at(y),
        input |> Enum.at(x + 2) |> Enum.at(y),
        input |> Enum.at(x + 3) |> Enum.at(y)
      ]
    end
  end

  defp find_vertical_reversed(input, x, y) do
    starting_row = Enum.at(input, x)

    if x - 3 >= 0 do
      ~c"XMAS" == [
        input |> Enum.at(x) |> Enum.at(y),
        input |> Enum.at(x - 1) |> Enum.at(y),
        input |> Enum.at(x - 2) |> Enum.at(y),
        input |> Enum.at(x - 3) |> Enum.at(y)
      ]
    end
  end

  defp find_diagonal_right(input, x, y) do
    starting_row = Enum.at(input, x)

    if x + 3 < Enum.count(input) and y + 3 < Enum.count(starting_row) do
      ~c"XMAS" == [
        input |> Enum.at(x) |> Enum.at(y),
        input |> Enum.at(x + 1) |> Enum.at(y + 1),
        input |> Enum.at(x + 2) |> Enum.at(y + 2),
        input |> Enum.at(x + 3) |> Enum.at(y + 3)
      ]
    end
  end

  defp find_diagonal_left(input, x, y) do
    starting_row = Enum.at(input, x)

    if x + 3 < Enum.count(input) and y - 3 >= 0 do
      ~c"XMAS" == [
        input |> Enum.at(x) |> Enum.at(y),
        input |> Enum.at(x + 1) |> Enum.at(y - 1),
        input |> Enum.at(x + 2) |> Enum.at(y - 2),
        input |> Enum.at(x + 3) |> Enum.at(y - 3)
      ]
    end
  end

  defp find_diagonal_reversed_right(input, x, y) do
    starting_row = Enum.at(input, x)

    if x - 3 >= 0 and y + 3 < Enum.count(starting_row) do
      ~c"XMAS" == [
        input |> Enum.at(x) |> Enum.at(y),
        input |> Enum.at(x - 1) |> Enum.at(y + 1),
        input |> Enum.at(x - 2) |> Enum.at(y + 2),
        input |> Enum.at(x - 3) |> Enum.at(y + 3)
      ]
    end
  end

  defp find_diagonal_reversed_left(input, x, y) do
    starting_row = Enum.at(input, x)

    if x - 3 >= 0 and y - 3 >= 0 do
      ~c"XMAS" == [
        input |> Enum.at(x) |> Enum.at(y),
        input |> Enum.at(x - 1) |> Enum.at(y - 1),
        input |> Enum.at(x - 2) |> Enum.at(y - 2),
        input |> Enum.at(x - 3) |> Enum.at(y - 3)
      ]
    end
  end

  @spec part2(input_t()) :: integer()
  def part2(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(_overall = 0, fn {row, y}, overall ->
      row_sum =
        row
        |> Enum.with_index()
        |> Enum.reduce(_row_sum = 0, fn
          {?A, x}, row_sum -> row_sum + find_mas(input, {x, y})
          _, row_sum -> row_sum
        end)

      overall + row_sum
    end)
  end

  defp find_mas(_input, {0, _y}), do: 0
  defp find_mas(_input, {_x, 0}), do: 0
  defp find_mas(input, {x, _y}) when x + 1 >= length(hd(input)), do: 0
  defp find_mas(input, {_x, y}) when y + 1 >= length(input), do: 0

  defp find_mas(input, {x, y} = central_point) do
    if find_first_diagonal(input, central_point) and find_second_diagonal(input, central_point) do
      1
    else
      0
    end
  end

  defp find_first_diagonal(input, {x, y} = central_point) do
    diagonal = [
      get_point(input, {x - 1, y + 1}),
      get_point(input, central_point),
      get_point(input, {x + 1, y - 1})
    ]

    case diagonal do
      ~c"MAS" -> true
      ~c"SAM" -> true
      _ -> false
    end
  end

  defp find_second_diagonal(input, {x, y} = central_point) do
    diagonal = [
      get_point(input, {x - 1, y - 1}),
      get_point(input, central_point),
      get_point(input, {x + 1, y + 1})
    ]

    case diagonal do
      ~c"MAS" -> true
      ~c"SAM" -> true
      _ -> false
    end
  end

  defp get_point(input, {x, y}) do
    input |> Enum.at(y) |> Enum.at(x)
  end
end
