defmodule Mix.Tasks.Hello do
  @moduledoc """
  usage: mix hello arg
  """
  use Mix.Task

  @impl Mix.Task
  def run(args) when length(args) == 3 do
    path = List.first(args)
    [_ | tail] = args
    count = List.first(tail)
    |> String.to_integer()
    column = List.last(tail)
    MarketData.main(path, count, column)
  end

  @impl Mix.Task
  def run(_args) do
    IO.puts("Usage: mix hello --path='path', --count=n, --column='columnToBeSorted")
  end
end
