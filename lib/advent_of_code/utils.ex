defmodule AdventOfCode.Utils do

  def split_input_by_newline(input) do
    input
    |> String.split("\n", trim: true)
  end
end
