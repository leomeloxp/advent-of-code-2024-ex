defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  @tag :skip
  test "part1" do
    {:ok, input} = File.read("priv/input/day_01_example.txt")
    result = part1(input)

    assert result == 11
  end

  @tag :skip
  test "part2" do
    {:ok, input} = File.read("priv/input/day_01_example.txt")
    result = part2(input)

    assert result == 31
  end
end
