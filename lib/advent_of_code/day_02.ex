defmodule AdventOfCode.Day02 do
  import AdventOfCode.Utils
  import Utils.GuardPipe

  def part1(args) do
    input = args || AdventOfCode.Input.get!(2)
    split_reports(input)
    |> Enum.filter(fn report ->
      try do
        Enum.chunk_every(report, 2, 1, :discard)
        |> IO.inspect(label: "chunked")
        |> Enum.reduce(%{direction: nil}, fn [item, next_item], acc ->
          direction = {item, next_item, acc.direction}
            |> has_safe_distance?
            ~> has_same_direction?
            |>should_halt?

          %{
            direction: direction
          }
        end)
      catch
        {:halt, result} -> result
      end
    end)
    |> Enum.count()
  end

  def part2(_args) do
  end

  defp split_reports(input) do
    split_input_by_newline(input)
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp has_safe_distance?({item, next_item, direction}) do
    distance = next_item - item
    if abs(distance) > 3 || abs(distance) == 0 do
      {:error, :unsafe_distance}
    else
      {:ok, {item, next_item, direction}}
    end
  end

  defp has_same_direction?({item, next_item, direction}) do
    new_direction = (item < next_item && :increasing) || :decreasing
    if !is_nil(direction) && direction != new_direction do
      {:error, :wrong_direction}
    else
      {:ok, {item, next_item, new_direction}}
    end
  end


  defp should_halt?({:error, reason}) do
    IO.inspect(reason, label: "reason")
    throw({:halt, false})
  end

  defp should_halt?({:ok, result}) do
    elem(result, 2)
  end

end
