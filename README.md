# MarketData

The following market data chunk was received from the provider:
```
currencyPair price   changeAbsolute changePercent
EUR/USD     1.0735         -0.0045     -0.42
USD/JPY   112.0900          -0.494     -0.44
GBP/USD     1.2476         -0.0010     -0.08
AUD/USD     0.7648         -0.0032     -0.42
USD/CAD     1.3112          0.0092      0.71
USD/CHF     0.9927          0.0007      0.07
USD/CNY     6.8599         -0.0050     -0.07
EUR/JPY   120.3150         -1.1050     -0.91
EUR/GBP     0.8604         -0.0032     -0.37
```
a) Parse the string into a collection of objects.
NOTE: Do not assume & hardcode the properties but parse them from the header.
b) Retrieve the top 3 currency pairs with the biggest (percentage) changes from the data chunk.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `market_data` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:market_data, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/market_data>.

