defmodule MarketData do
  @moduledoc """
  Documentation for MarketData
  """

  def open_file(path), do: File.stream!(path, [], :line) |> Stream.map(&String.trim/1) |> Stream.map(&String.split(&1, " ", trim: true)) |> Enum.to_list()

  def get_struct_keys([head | _]), do: head

  def get_struct_values([_ | tail]), do: tail

  def create_struct(keys, values), do: Enum.map(values, fn row -> Enum.zip(keys, row) |> Enum.into(%{}) end)

  def cast_types(object), do: MarketData.Parser.parse_object(object) |> Enum.map(fn row -> Map.new(row) end)

  def get_top(object, column, n) do
    Enum.sort_by(object, fn map ->
      abs(Map.fetch!(map, column))
    end, :desc)
    |> Enum.take(n)
  end

  def main(path, count, column) do
    object = open_file(path)
    keys = get_struct_keys(object)
    values = get_struct_values(object)
    struct = create_struct(keys, values)
    struct_typed = cast_types(struct)

    option = IO.gets("Menu:\n a) Get top 3. \n Select an option: ") |> String.trim()

    case option do
      "a" ->  get_top(struct_typed, column, count) |> IO.inspect()
      _ -> "Wrong option, quitting..."
    end
  end

end
