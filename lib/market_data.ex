defmodule MarketData do
  @moduledoc """
  Documentation for MarketData
  """

  def open_file(path) do
    contents = File.stream!(path, [], :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, " ", trim: true))
    |> Enum.to_list()
    contents
  end

  def get_struct_keys(contents) do
    keys = List.first(contents)
    keys
  end

  def get_struct_values(contents) do
    [_ | tail] = contents
    values = tail
    values
  end

  def create_struct(keys, values) do
    objects = Enum.map(values, fn row ->
      Enum.zip(keys, row) |> Enum.into(%{})
    end)
    objects
  end

  def cast_types(object) do
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

  def get_top(object, column, n) do
    sorted_data = Enum.sort_by(object, &Map.fetch!(&1, column), :desc)
    |> Enum.take(n)
    sorted_data
  end

  def main() do
    path = IO.gets("Insert the path: ") |> String.trim() |> Path.expand()
    object = open_file(path)
    keys = get_struct_keys(object)
    values = get_struct_values(object)
    struct = create_struct(keys, values)
    struct_typed = cast_types(struct)

    option = IO.gets("Menu:\n a) Get top 3. \n Select an option: ") |> String.trim()

    case option do
      "a" -> column = IO.gets("Type the column name that you want to sort by: ") |> String.trim()
              top = get_top(struct_typed, column, 3)
              top
      _ -> "Wrong option, quitting..."
    end
  end

end
