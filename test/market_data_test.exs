defmodule MarketDataTest do
  use ExUnit.Case
  doctest MarketData

  describe "open_file/1" do
    test "opens file and reads contents if exists (5 cols)" do
      assert MarketData.open_file("test/tests/5_cols.txt") ==
        [
          ["currencyPair", "price", "changeAbsolute", "changePercent", "newCol"],
          ["EUR/USD", "1.0735", "-0.0045", "-0.42", "2.31"],
          ["USD/JPY", "112.0900", "-0.494", "-0.44", "4.21"],
          ["GBP/USD", "1.2476", "-0.0010", "-0.08", "41.1"],
          ["AUD/USD", "0.7648", "-0.0032", "-0.42", "531.1"],
          ["USD/CAD", "1.3112", "0.0092", "0.71", "75318571.351"],
          ["USD/CHF", "0.9927", "0.0007", "0.07", "75391591.75318573"],
          ["USD/CNY", "6.8599", "-0.0050", "-0.07", "0.2"],
          ["EUR/JPY", "120.3150", "-1.1050", "-0.91", "-0.421"],
          ["EUR/GBP", "0.8604", "-0.0032", "-0.37", "-2141"]
        ]
    end

    test "opens file and reads contents if exists (10 cols)" do
      assert MarketData.open_file("test/tests/10_cols.txt") ==
        [
          ["currencyPair", "price", "changeAbsolute", "changePercent", "newCol", "nextCol", "lateCol", "anotherCol", "ColCol"],
          ["EUR/USD", "1.0735", "-0.0045", "-0.42", "2.31", "591", "89031", "-41", "colcol"],
          ["USD/JPY", "112.0900", "-0.494", "-0.44", "4.21", "531", "21", "-531", "colcol"],
          ["GBP/USD", "1.2476", "-0.0010", "-0.08", "41.1", "1531", "2", "-752", "colcol"],
          ["AUD/USD", "0.7648", "-0.0032", "-0.42", "531.1", "5381", "1", "-4682", "colcol"],
          ["USD/CAD", "1.3112", "0.0092", "0.71", "75318571.351", "931", "2", "-351", "colcol"],
          ["USD/CHF", "0.9927", "0.0007", "0.07", "75391591.75318573", "859318", "3", "-31", "colcol"],
          ["USD/CNY", "6.8599", "-0.0050", "-0.07", "0.2", "58391", "41", "-1121", "colcol"],
          ["EUR/JPY", "120.3150", "-1.1050", "-0.91", "-0.421", "85318", "41", "-111", "colcol"],
          ["EUR/GBP", "0.8604", "-0.0032", "-0.37", "-2141", "85310", "21", "-11111", "colcol"]
        ]
    end

    test "raise error on non-existent path" do
      assert_raise File.Error, fn ->
        MarketData.open_file("gjdkajgaklgjda.txt")
      end
    end
  end

  describe "get_struct_keys/1" do
    test "get keys from 5 cols" do
      content = MarketData.open_file("test/tests/5_cols.txt")
      assert MarketData.get_struct_keys(content) == ["currencyPair", "price", "changeAbsolute", "changePercent", "newCol"]
    end

    test "get keys from 10 cols" do
      content = MarketData.open_file("test/tests/10_cols.txt")
      assert MarketData.get_struct_keys(content) == ["currencyPair", "price", "changeAbsolute", "changePercent", "newCol", "nextCol", "lateCol", "anotherCol", "ColCol"]
    end

    test "read any key as string" do
      content = MarketData.open_file("test/tests/keys_error.txt")
      assert MarketData.get_struct_keys(content) == ["currencyPair", "price", "changeAbsolute", "changePercent", "6"]
    end
  end

  describe "get_struct_values/1" do
    test "get values from 5 cols" do
      content = MarketData.open_file("test/tests/5_cols.txt")
      assert MarketData.get_struct_values(content) ==
      [
        ["EUR/USD", "1.0735", "-0.0045", "-0.42", "2.31"],
        ["USD/JPY", "112.0900", "-0.494", "-0.44", "4.21"],
        ["GBP/USD", "1.2476", "-0.0010", "-0.08", "41.1"],
        ["AUD/USD", "0.7648", "-0.0032", "-0.42", "531.1"],
        ["USD/CAD", "1.3112", "0.0092", "0.71", "75318571.351"],
        ["USD/CHF", "0.9927", "0.0007", "0.07", "75391591.75318573"],
        ["USD/CNY", "6.8599", "-0.0050", "-0.07", "0.2"],
        ["EUR/JPY", "120.3150", "-1.1050", "-0.91", "-0.421"],
        ["EUR/GBP", "0.8604", "-0.0032", "-0.37", "-2141"]
      ]
    end

    test "get values from 10 cols" do
      content = MarketData.open_file("test/tests/10_cols.txt")
      assert MarketData.get_struct_values(content) ==
        [
          ["EUR/USD", "1.0735", "-0.0045", "-0.42", "2.31", "591", "89031", "-41", "colcol"],
          ["USD/JPY", "112.0900", "-0.494", "-0.44", "4.21", "531", "21", "-531", "colcol"],
          ["GBP/USD", "1.2476", "-0.0010", "-0.08", "41.1", "1531", "2", "-752", "colcol"],
          ["AUD/USD", "0.7648", "-0.0032", "-0.42", "531.1", "5381", "1", "-4682", "colcol"],
          ["USD/CAD", "1.3112", "0.0092", "0.71", "75318571.351", "931", "2", "-351", "colcol"],
          ["USD/CHF", "0.9927", "0.0007", "0.07", "75391591.75318573", "859318", "3", "-31", "colcol"],
          ["USD/CNY", "6.8599", "-0.0050", "-0.07", "0.2", "58391", "41", "-1121", "colcol"],
          ["EUR/JPY", "120.3150", "-1.1050", "-0.91", "-0.421", "85318", "41", "-111", "colcol"],
          ["EUR/GBP", "0.8604", "-0.0032", "-0.37", "-2141", "85310", "21", "-11111", "colcol"]
        ]
      end
  end

  describe "create_struct/2" do
    test "struct has list of structs format" do
      content = MarketData.open_file("test/tests/5_cols.txt")
      keys = MarketData.get_struct_keys(content)
      values = MarketData.get_struct_values(content)
      assert MarketData.create_struct(keys, values) ==
        [
          %{
            "changeAbsolute" => "-0.0045",
            "changePercent" => "-0.42",
            "currencyPair" => "EUR/USD",
            "newCol" => "2.31",
            "price" => "1.0735"
          },
          %{
            "changeAbsolute" => "-0.494",
            "changePercent" => "-0.44",
            "currencyPair" => "USD/JPY",
            "newCol" => "4.21",
            "price" => "112.0900"
          },
          %{
            "changeAbsolute" => "-0.0010",
            "changePercent" => "-0.08",
            "currencyPair" => "GBP/USD",
            "newCol" => "41.1",
            "price" => "1.2476"
          },
          %{
            "changeAbsolute" => "-0.0032",
            "changePercent" => "-0.42",
            "currencyPair" => "AUD/USD",
            "newCol" => "531.1",
            "price" => "0.7648"
          },
          %{
            "changeAbsolute" => "0.0092",
            "changePercent" => "0.71",
            "currencyPair" => "USD/CAD",
            "newCol" => "75318571.351",
            "price" => "1.3112"
          },
          %{
            "changeAbsolute" => "0.0007",
            "changePercent" => "0.07",
            "currencyPair" => "USD/CHF",
            "newCol" => "75391591.75318573",
            "price" => "0.9927"
          },
          %{
            "changeAbsolute" => "-0.0050",
            "changePercent" => "-0.07",
            "currencyPair" => "USD/CNY",
            "newCol" => "0.2",
            "price" => "6.8599"
          },
          %{
            "changeAbsolute" => "-1.1050",
            "changePercent" => "-0.91",
            "currencyPair" => "EUR/JPY",
            "newCol" => "-0.421",
            "price" => "120.3150"
          },
          %{
            "changeAbsolute" => "-0.0032",
            "changePercent" => "-0.37",
            "currencyPair" => "EUR/GBP",
            "newCol" => "-2141",
            "price" => "0.8604"
          }
        ]
    end

    assert "struct keys are always strings" do
      content = MarketData.open_file("test/tests/keys_error.txt")
      keys = MarketData.get_struct_keys(content)
      values = MarketData.get_struct_values(content)
      assert MarketData.create_struct(keys, values) ==
      [
        %{
          "6" => "2.31",
          "changeAbsolute" => "-0.0045",
          "changePercent" => "-0.42",
          "currencyPair" => "EUR/USD",
          "price" => "1.0735"
        },
        %{
          "6" => "4.21",
          "changeAbsolute" => "-0.494",
          "changePercent" => "-0.44",
          "currencyPair" => "USD/JPY",
          "price" => "112.0900"
        },
        %{
          "6" => "41.1",
          "changeAbsolute" => "-0.0010",
          "changePercent" => "-0.08",
          "currencyPair" => "GBP/USD",
          "price" => "1.2476"
        },
        %{
          "6" => "531.1",
          "changeAbsolute" => "-0.0032",
          "changePercent" => "-0.42",
          "currencyPair" => "AUD/USD",
          "price" => "0.7648"
        },
        %{
          "6" => "75318571.351",
          "changeAbsolute" => "0.0092",
          "changePercent" => "0.71",
          "currencyPair" => "USD/CAD",
          "price" => "1.3112"
        },
        %{
          "6" => "75391591.75318573",
          "changeAbsolute" => "0.0007",
          "changePercent" => "0.07",
          "currencyPair" => "USD/CHF",
          "price" => "0.9927"
        },
        %{
          "6" => "0.2",
          "changeAbsolute" => "-0.0050",
          "changePercent" => "-0.07",
          "currencyPair" => "USD/CNY",
          "price" => "6.8599"
        },
        %{
          "6" => "-0.421",
          "changeAbsolute" => "-1.1050",
          "changePercent" => "-0.91",
          "currencyPair" => "EUR/JPY",
          "price" => "120.3150"
        },
        %{
          "6" => "-2141",
          "changeAbsolute" => "-0.0032",
          "changePercent" => "-0.37",
          "currencyPair" => "EUR/GBP",
          "price" => "0.8604"
        }
      ]
    end
  end

  describe "cast_type/1" do
    test "casts from string to integer/float" do
      content = MarketData.open_file("test/tests/5_cols.txt")
      keys = MarketData.get_struct_keys(content)
      values = MarketData.get_struct_values(content)
      struct = MarketData.create_struct(keys, values)
      assert MarketData.cast_types(struct) ==
      [
        %{
          "changeAbsolute" => -0.0045,
          "changePercent" => -0.42,
          "currencyPair" => "EUR/USD",
          "newCol" => 2.31,
          "price" => 1.0735
        },
        %{
          "changeAbsolute" => -0.494,
          "changePercent" => -0.44,
          "currencyPair" => "USD/JPY",
          "newCol" => 4.21,
          "price" => 112.09
        },
        %{
          "changeAbsolute" => -0.001,
          "changePercent" => -0.08,
          "currencyPair" => "GBP/USD",
          "newCol" => 41.1,
          "price" => 1.2476
        },
        %{
          "changeAbsolute" => -0.0032,
          "changePercent" => -0.42,
          "currencyPair" => "AUD/USD",
          "newCol" => 531.1,
          "price" => 0.7648
        },
        %{
          "changeAbsolute" => 0.0092,
          "changePercent" => 0.71,
          "currencyPair" => "USD/CAD",
          "newCol" => 75318571.351,
          "price" => 1.3112
        },
        %{
          "changeAbsolute" => 0.0007,
          "changePercent" => 0.07,
          "currencyPair" => "USD/CHF",
          "newCol" => 75391591.75318573,
          "price" => 0.9927
        },
        %{
          "changeAbsolute" => -0.005,
          "changePercent" => -0.07,
          "currencyPair" => "USD/CNY",
          "newCol" => 0.2,
          "price" => 6.8599
        },
        %{
          "changeAbsolute" => -1.105,
          "changePercent" => -0.91,
          "currencyPair" => "EUR/JPY",
          "newCol" => -0.421,
          "price" => 120.315
        },
        %{
          "changeAbsolute" => -0.0032,
          "changePercent" => -0.37,
          "currencyPair" => "EUR/GBP",
          "newCol" => -2141.0,
          "price" => 0.8604
        }
      ]
    end

    test "casts only values, not the keys" do
      content = MarketData.open_file("test/tests/keys_error.txt")
      keys = MarketData.get_struct_keys(content)
      values = MarketData.get_struct_values(content)
      struct = MarketData.create_struct(keys, values)
      assert MarketData.cast_types(struct) ==
        [
          %{
            "6" => 2.31,
            "changeAbsolute" => -0.0045,
            "changePercent" => -0.42,
            "currencyPair" => "EUR/USD",
            "price" => 1.0735
          },
          %{
            "6" => 4.21,
            "changeAbsolute" => -0.494,
            "changePercent" => -0.44,
            "currencyPair" => "USD/JPY",
            "price" => 112.09
          },
          %{
            "6" => 41.1,
            "changeAbsolute" => -0.001,
            "changePercent" => -0.08,
            "currencyPair" => "GBP/USD",
            "price" => 1.2476
          },
          %{
            "6" => 531.1,
            "changeAbsolute" => -0.0032,
            "changePercent" => -0.42,
            "currencyPair" => "AUD/USD",
            "price" => 0.7648
          },
          %{
            "6" => 75318571.351,
            "changeAbsolute" => 0.0092,
            "changePercent" => 0.71,
            "currencyPair" => "USD/CAD",
            "price" => 1.3112
          },
          %{
            "6" => 75391591.75318573,
            "changeAbsolute" => 0.0007,
            "changePercent" => 0.07,
            "currencyPair" => "USD/CHF",
            "price" => 0.9927
          },
          %{
            "6" => 0.2,
            "changeAbsolute" => -0.005,
            "changePercent" => -0.07,
            "currencyPair" => "USD/CNY",
            "price" => 6.8599
          },
          %{
            "6" => -0.421,
            "changeAbsolute" => -1.105,
            "changePercent" => -0.91,
            "currencyPair" => "EUR/JPY",
            "price" => 120.315
          },
          %{
            "6" => -2141.0,
            "changeAbsolute" => -0.0032,
            "changePercent" => -0.37,
            "currencyPair" => "EUR/GBP",
            "price" => 0.8604
          }
        ]
    end
  end

  describe "get_top/3" do
    test "sorts by any column" do
      content = MarketData.open_file("test/tests/keys_error.txt")
      keys = MarketData.get_struct_keys(content)
      values = MarketData.get_struct_values(content)
      struct = MarketData.create_struct(keys, values)
      casted = MarketData.cast_types(struct)
      assert MarketData.get_top(casted, "6", 3) ==
        [
          %{
            "6" => 75391591.75318573,
            "changeAbsolute" => 0.0007,
            "changePercent" => 0.07,
            "currencyPair" => "USD/CHF",
            "price" => 0.9927
          },
          %{
            "6" => 75318571.351,
            "changeAbsolute" => 0.0092,
            "changePercent" => 0.71,
            "currencyPair" => "USD/CAD",
            "price" => 1.3112
          },
          %{
            "6" => 531.1,
            "changeAbsolute" => -0.0032,
            "changePercent" => -0.42,
            "currencyPair" => "AUD/USD",
            "price" => 0.7648
          }
        ]
    end

    test "raises KeyError on wrong column" do
      content = MarketData.open_file("test/tests/keys_error.txt")
      keys = MarketData.get_struct_keys(content)
      values = MarketData.get_struct_values(content)
      struct = MarketData.create_struct(keys, values)
      casted = MarketData.cast_types(struct)
      assert_raise KeyError, fn ->
        MarketData.get_top(casted, "gjak", 3)
      end
    end
  end

end
