defmodule Utils.GuardPipe do
  @moduledoc ~S"""
  When a value input into the pipe is an error tuple, the subsequent function in the pipeline will not execute, and the error tuple is immediately returned as the output.

  Example:

  iex> {:error, 9} ~> Kernel.+(1)
  {:error, 9}

  On the other hand, if the input is an `ok` tuple, its inner value is extracted and passed on to the next function in the pipeline. The final output of the pipe will be either an `ok` or an `error` tuple.

  Examples:

  iex> {:ok, 9} ~> Kernel.+(1)
  {:ok, 10}

  iex> {:ok, 2} ~> Kernel.+(4) ~> Kernel.+(4)
  {:ok, 10}

  If the input value is neither an `ok` nor an `error` tuple, an `InvalidGuardPipeUsageError` is triggered.

  To pass non-tuple values through a pipeline, use a standard pipe (|>) instead of the guard pipe (~>).
  """

  defmodule InvalidGuardPipeUsageError do
    defexception [:exception, :message]
  end

  # This approach stops Dialyzer from detecting
  # unreachable sections within the case statement.
  def passthrough(x), do: x

  def wrap({:error, error}), do: {:error, error}
  def wrap({:ok, result}), do: {:ok, result}
  def wrap(catchall), do: {:ok, catchall}

  defmacro left ~> right do
    quote do
      unquote(left)
      |> passthrough()
      |> case do
        {:error, error} ->
          {:error, error}

        {:ok, value} ->
          value |> unquote(right) |> wrap

        value ->
          raise(
            InvalidGuardPipeUsageError,
            message:
              "invalid use of the GuardPipe (~>) macro detected: the value piped in must conform to the format {:ok | :error, _}, input was instead: \"#{
                value
              }\""
          )
      end
    end
  end
end
