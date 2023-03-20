defmodule MarketData do
  @moduledoc """
  Documentation for MarketData
  """

  def open_file(path), do: File.stream!(path, [], :line) |> Stream.map(&String.trim/1) |> Stream.map(&String.split(&1, " ", trim: true)) |> Enum.to_list()

  def get_struct_keys([head | _]), do: head

  def get_struct_values([_ | tail]), do: tail

  def create_struct(keys, values), do: Enum.map(values, fn row -> Enum.zip(keys, row) |> Enum.into(%{}) end)

  def cast_types(object) do
    result = MarketData.Parser.parse_object(object)
    result = Enum.map(result, fn row ->
      Map.new(row)
    end)
    result
  end

  def get_top(object, column, n), do: Enum.sort_by(object, &Map.fetch!(&1, column), :desc) |> Enum.take(n)

  def main(path) do
    object = open_file(path)
    keys = get_struct_keys(object)
    values = get_struct_values(object)
    struct = create_struct(keys, values)
    struct_typed = cast_types(struct)

    option = IO.gets("Menu:\n a) Get top 3. \n Select an option: ") |> String.trim()

    case option do
      "a" -> column = IO.gets("Type the column name that you want to sort by: ") |> String.trim()
              top = get_top(struct_typed, column, 3)
              IO.inspect(top)
      _ -> "Wrong option, quitting..."
    end
  end

end
