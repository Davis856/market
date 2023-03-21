defmodule Mix.Tasks.Hello do
  @moduledoc """
  usage: mix hello arg
  """
  use Mix.Task

  @impl Mix.Task
  def run(args) when length(args) == 3 do
    path = OptionParser.parse(["--path"], strict: [path: :string])
    count = OptionParser.parse(["--count"], strict: [count: :string])
    column = OptionParser.parse(["--column"], strict: [column: :string])

    MarketData.main(path, count, column)
  end


  @impl Mix.Task
  def run(args) do
    IO.puts("Usage: mix hello --path='path', --count=n, --column='columnToBeSorted")
  end
end
