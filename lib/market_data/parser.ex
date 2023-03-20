defmodule MarketData.Parser do

  def parse_row(row) do
    Enum.map(row, fn {key, value} ->
      with {float, _} <- Float.parse(value) do
        {key, float}
      end

      with {integer, _} <- Integer.parse(value) do
        {key, integer}
      end

      {key, value}
      end)
  end

  def parse_object(object), do: Enum.map(object, &parse_row/1)

end
