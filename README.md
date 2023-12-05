# Si

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/packages/si), the package can be installed
by adding `si` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:si, "~> 1.0"}
  ]
end
```

## Basic usage

### Unit creation

```elixir
iex(1)> SI.Unit.Kilogram.create(12.3)
%SI.Unit.Kilogram{value: 12.3}
```

### Unit converting

For example if we wanna convert `kilograms` to `grams` we can use following code:

```elixir
iex(1)> kg = SI.Unit.Kilogram.create(12.3)
%SI.Unit.Kilogram{value: 12.3}
iex(1)> SI.Unit.Gram.create(kg)
%SI.Unit.Gram{value: 12300}
```

## Docs

The docs can be found at [https://hexdocs.pm/si](https://hexdocs.pm/si).

## License

The `SI` is released under the Apache License 2.0 - see the [LICENSE](LICENSE) file.

