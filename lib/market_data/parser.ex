defmodule MarketData.Parser do

  def parse_row(row) do
    Enum.map(row, fn {key, value} ->
      with {float, _} <- Float.parse(value) do
        {key, float}
      else
        _ -> with {integer, _} <- Integer.parse(value) do
          {key, integer}
        else
          _ -> {key, value}
        end
      end
      end)
  end

  def parse_object(object), do: Enum.map(object, &parse_row/1)

end
