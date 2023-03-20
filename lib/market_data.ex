defmodule MarketData do
  @moduledoc """
  Documentation for MarketData
  """

  @path "data/data.txt"
  def open_file(@path) do
    contents = File.stream!(@path, [], :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, " ", trim: true))
    |> Enum.to_list()
    contents
  end

  def get_struct_keys() do
    content = open_file(@path)
    keys = List.first(content)
    keys
  end

  def get_struct_values() do
    content = open_file(@path)
    [_ | tail] = content
    values = tail
    values
  end

  def create_struct() do
    keys = get_struct_keys()
    values = get_struct_values()
    objects = Enum.map(values, fn row ->
      Enum.zip(keys, row) |> Enum.into(%{})
    end)
    objects
  end

  def cast_types() do
    object = create_struct()
    result = Enum.map(object, fn row ->
      Enum.map(row, fn {key, value} ->
        case Float.parse(value) do
          {float, _} -> {key, float}
          :error -> case Integer.parse(value) do
            {integer, _} -> {key, integer}
            :error -> {key, value}
          end
        end
      end)
    end)
    result = Enum.map(result, fn row ->
      Map.new(row)
    end)
    result
  end

  def get_top(column, n) do
    object = cast_types()
    sorted_data = Enum.sort_by(object, &Map.fetch!(&1, column), :desc)
    |> Enum.take(n)
    sorted_data
  end

end
