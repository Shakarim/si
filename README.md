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

### Adding custom conversions

By default library provides converting between units in the same quantity. That means, by default we can convert `nanogram` to `kilogram` or `decagram` to `gram` because they are belongs the same quantity. Converting between different quantities will raise an error.

```elixir
iex(1)> SI.Unit.Gram.create SI.Unit.Ampere.create(123)
** (Protocol.UndefinedError) protocol SI.Unit.Gram.Converter not implemented for %SI.Unit.Ampere{value: 123.0} of type SI.Unit.Ampere (a struct). This protocol is implemented for the
 following type(s): Float, Integer, SI.Unit.Attogram, SI.Unit.Centigram, SI.Unit.Decagram, SI.Unit.Decigram, SI.Unit.Exagram, SI.Unit.Femtogram, SI.Unit.Gigagram, SI.Unit.Hectogram, 
SI.Unit.Kilogram, SI.Unit.Megagram, SI.Unit.Microgram, SI.Unit.Milligram, SI.Unit.Nanogram, SI.Unit.Petagram, SI.Unit.Picogram, SI.Unit.Teragram
    (si 1.0.0) lib/unit/gram.ex:3: SI.Unit.Gram.Converter.impl_for!/1
    (si 1.0.0) lib/unit/gram.ex:3: SI.Unit.Gram.Converter.create/1
    iex:1: (file)
```

But you can make your own converting protocol if it necessary.

```elixir
defimpl SI.Unit.Gram.Converter, for: SI.Unit.Ampere do
  def create(term), do: SI.Unit.Gram.create(term.value * 3)
end
```

and now new converting is allowed

```elixir
iex(1)> SI.Unit.Gram.create SI.Unit.Ampere.create(123)
%SI.Unit.Gram{value: 369.0}
```

## Docs

The docs can be found at [https://hexdocs.pm/si](https://hexdocs.pm/si).

## License

The `SI` is released under the Apache License 2.0 - see the [LICENSE](LICENSE) file.

