defmodule AdventOfCode.Day01 do
  import AdventOfCode.Utils

  def part1(args) do
    input = args || AdventOfCode.Input.get!(1)
    %{left: left, right: right} = split_input_into_columns(input)

    left = Enum.sort(left)
    right = Enum.sort(right)

    # Calculate the result
    Enum.with_index(left) |> Enum.map(fn {x, i} ->
      y = Enum.at(right, i)
      max(x - y, y - x)

    end) |> Enum.sum()
  end

  def part2(args) do
    input = args || AdventOfCode.Input.get!(1)
    %{left: left, right: right} = split_input_into_columns(input)

    right_frequencies = Enum.frequencies(right)

    # Calculate the result
    Enum.map(left, fn x ->
      y = right_frequencies[x] || 0
      x * y
    end) |> Enum.sum()
  end

  defp split_input_into_columns(input) do
    split_input_by_newline(input) |> Enum.reduce(%{left: [], right: []}, fn x, acc ->

      [a, b] = String.split(x, "   ", trim: true)
      %{
        left: acc.left ++ [String.to_integer(a)],
        right: acc.right ++ [String.to_integer(b)]
      }
    end)
  end
end
