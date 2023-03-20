defmodule Mix.Tasks.Hello do
  @moduledoc """
  usage: mix hello arg
  """
  use Mix.Task

  @impl Mix.Task
  def run(args) when length(args) == 1 do
    IO.puts(args)
    MarketData.main(args)
  end
end
