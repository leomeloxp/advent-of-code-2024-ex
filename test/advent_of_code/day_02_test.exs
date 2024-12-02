defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  @tag :skip
  test "part1" do
    {:ok, input} = File.read("priv/input/day_02_example.txt")
    result = part1(input)

    assert result == 2
  end

  @tag :skip
  test "part2" do
    {:ok, input} = File.read("priv/input/day_02_example.txt")
    result = part2(input)

    assert result == 4
  end
end
