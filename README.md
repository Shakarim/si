# Si

The library implements quantities and units which included to basic SI.

The **[International System of Units](https://en.wikipedia.org/wiki/International_System_of_Units)**, internationally known by the abbreviation SI (from French Système International), is the modern form of the [metric system](https://en.wikipedia.org/wiki/Metric_system) and the world's most widely used [system of measurement](https://en.wikipedia.org/wiki/System_of_measurement). Established and maintained by the [General Conference on Weights and Measures](https://en.wikipedia.org/wiki/General_Conference_on_Weights_and_Measures), it is the only system of measurement with an official status in nearly every country in the world, employed in science, technology, industry, and everyday commerce.

## Installation

If [available in Hex](https://hex.pm/packages/si), the package can be installed
by adding `si` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:si, "~> 1.5"}
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
** (Protocol.UndefinedError) protocol SI.Unit.Gram.Generator not implemented for %SI.Unit.Ampere{value: 123.0} of type SI.Unit.Ampere (a struct). This protocol is implemented for the
 following type(s): Float, Integer, SI.Unit.Attogram, SI.Unit.Centigram, SI.Unit.Decagram, SI.Unit.Decigram, SI.Unit.Exagram, SI.Unit.Femtogram, SI.Unit.Gigagram, SI.Unit.Hectogram, 
SI.Unit.Kilogram, SI.Unit.Megagram, SI.Unit.Microgram, SI.Unit.Milligram, SI.Unit.Nanogram, SI.Unit.Petagram, SI.Unit.Picogram, SI.Unit.Teragram
    (si 1.0.0) lib/unit/gram.ex:3: SI.Unit.Gram.Generator.impl_for!/1
    (si 1.0.0) lib/unit/gram.ex:3: SI.Unit.Gram.Generator.create/1
    iex:1: (file)
```

But you can make your own converting protocol if it necessary.

```elixir
defimpl SI.Unit.Gram.Generator, for: SI.Unit.Ampere do
  def create(term), do: SI.Unit.Gram.create(term.value * 3)
end
```

and now new converting is allowed

```elixir
iex(1)> SI.Unit.Gram.create SI.Unit.Ampere.create(123)
%SI.Unit.Gram{value: 369.0}
```

## Available modules
Basically `SI` provides 7 quantities and 7 basic units for them.

### Quantities and they inits
| Name                      | Typical symbol | Module           |
|---------------------------|----------------|------------------|
| time                      | `t`            | SI.Unit.Second   |
| length                    | `l`            | SI.Unit.Meter    |
| mass                      | `m`            | SI.Unit.Kilogram |
| electric current          | `I`            | SI.Unit.Ampere   |
| thermodynamic temperature | `T`            | SI.Unit.Kelvin   |
| amount of substance       | `n`            | SI.Unit.Mole     |
| luminous intensity        | `lv`           | SI.Unit.Candela  |

### Basic units

| Name    | Symbol | Module             |
|---------|--------|--------------------|
| ampere  | `A`    | `SI.Unit.Ampere`   |
| candela | `cd`   | `SI.Unit.Candela`  |
| gram    | `g`    | `SI.Unit.Gram`     |
| kelvin  | `K`    | `SI.Unit.Kelvin`   |
| meter   | `m`    | `SI.Unit.Meter`    |
| mole    | `mol`  | `SI.Unit.Mole`     |
| second  | `s`    | `SI.Unit.Second`   |

### Getting all default available modules

Getting all default quantities

```elixir
iex(1)> SI.quantities
[
  mass: SI.Quantity.Mass,
  amount_of_substance: SI.Quantity.AmountOfSubstance,
  time: SI.Quantity.Time,
  thermodynamic_temperature: SI.Quantity.ThermodynamicTemperature,
  luminous_intensity: SI.Quantity.LuminousIntensity,
  length: SI.Quantity.Length,
  electric_current: SI.Quantity.ElectricCurrent
]
```

Getting all default available modules grouped by quantity symbols

```elixir
iex(1)> SI.units
[
  time: [
    second: SI.Unit.Second,
    exasecond: SI.Unit.Exasecond,
    petasecond: SI.Unit.Petasecond,
    terasecond: SI.Unit.Terasecond,
    gigasecond: SI.Unit.Gigasecond,
    megasecond: SI.Unit.Megasecond,
    kilosecond: SI.Unit.Kilosecond,
    hectosecond: SI.Unit.Hectosecond,
    decasecond: SI.Unit.Decasecond,
    decisecond: SI.Unit.Decisecond,
    centisecond: SI.Unit.Centisecond,
    millisecond: SI.Unit.Millisecond,
    microsecond: SI.Unit.Microsecond,
    nanosecond: SI.Unit.Nanosecond,
    picosecond: SI.Unit.Picosecond,
    femtosecond: SI.Unit.Femtosecond,
    attosecond: SI.Unit.Attosecond
  ],
  thermodynamic_temperature: [
    kelvin: SI.Unit.Kelvin,
    exakelvin: SI.Unit.Exakelvin,
    petakelvin: SI.Unit.Petakelvin,
    terakelvin: SI.Unit.Terakelvin,
    gigakelvin: SI.Unit.Gigakelvin,
    megakelvin: SI.Unit.Megakelvin,
    kilokelvin: SI.Unit.Kilokelvin,
    hectokelvin: SI.Unit.Hectokelvin,
    decakelvin: SI.Unit.Decakelvin,
    decikelvin: SI.Unit.Decikelvin,
    centikelvin: SI.Unit.Centikelvin,
    millikelvin: SI.Unit.Millikelvin,
    microkelvin: SI.Unit.Microkelvin,
    nanokelvin: SI.Unit.Nanokelvin,
    picokelvin: SI.Unit.Picokelvin,
    femtokelvin: SI.Unit.Femtokelvin,
    attokelvin: SI.Unit.Attokelvin
  ],
  luminous_intensity: [
    candela: SI.Unit.Candela,
    exacandela: SI.Unit.Exacandela,
    petacandela: SI.Unit.Petacandela,
    teracandela: SI.Unit.Teracandela,
    gigacandela: SI.Unit.Gigacandela,
    megacandela: SI.Unit.Megacandela,
    kilocandela: SI.Unit.Kilocandela,
    hectocandela: SI.Unit.Hectocandela,
    decacandela: SI.Unit.Decacandela,
    decicandela: SI.Unit.Decicandela,
    centicandela: SI.Unit.Centicandela,
    millicandela: SI.Unit.Millicandela,
    microcandela: SI.Unit.Microcandela,
    nanocandela: SI.Unit.Nanocandela,
    picocandela: SI.Unit.Picocandela,
    femtocandela: SI.Unit.Femtocandela,
    attocandela: SI.Unit.Attocandela
  ],
  length: [
    meter: SI.Unit.Meter,
    exameter: SI.Unit.Exameter,
    petameter: SI.Unit.Petameter,
    terameter: SI.Unit.Terameter,
    gigameter: SI.Unit.Gigameter,
    megameter: SI.Unit.Megameter,
    kilometer: SI.Unit.Kilometer,
    hectometer: SI.Unit.Hectometer,
    decameter: SI.Unit.Decameter,
    decimeter: SI.Unit.Decimeter,
    centimeter: SI.Unit.Centimeter,
    millimeter: SI.Unit.Millimeter,
    micrometer: SI.Unit.Micrometer,
    nanometer: SI.Unit.Nanometer,
    picometer: SI.Unit.Picometer,
    femtometer: SI.Unit.Femtometer,
    attometer: SI.Unit.Attometer
  ],
  electric_current: [
    ampere: SI.Unit.Ampere,
    exaampere: SI.Unit.Exaampere,
    petaampere: SI.Unit.Petaampere,
    teraampere: SI.Unit.Teraampere,
    gigaampere: SI.Unit.Gigaampere,
    megaampere: SI.Unit.Megaampere,
    kiloampere: SI.Unit.Kiloampere,
    hectoampere: SI.Unit.Hectoampere,
    decaampere: SI.Unit.Decaampere,
    deciampere: SI.Unit.Deciampere,
    centiampere: SI.Unit.Centiampere,
    milliampere: SI.Unit.Milliampere,
    microampere: SI.Unit.Microampere,
    nanoampere: SI.Unit.Nanoampere,
    picoampere: SI.Unit.Picoampere,
    femtoampere: SI.Unit.Femtoampere,
    attoampere: SI.Unit.Attoampere
  ],
  amount_of_substance: [
    mole: SI.Unit.Mole,
    examole: SI.Unit.Examole,
    petamole: SI.Unit.Petamole,
    teramole: SI.Unit.Teramole,
    gigamole: SI.Unit.Gigamole,
    megamole: SI.Unit.Megamole,
    kilomole: SI.Unit.Kilomole,
    hectomole: SI.Unit.Hectomole,
    decamole: SI.Unit.Decamole,
    decimole: SI.Unit.Decimole,
    centimole: SI.Unit.Centimole,
    millimole: SI.Unit.Millimole,
    micromole: SI.Unit.Micromole,
    nanomole: SI.Unit.Nanomole,
    picomole: SI.Unit.Picomole,
    femtomole: SI.Unit.Femtomole,
    attomole: SI.Unit.Attomole
  ],
  mass: [
    gram: SI.Unit.Gram,
    exagram: SI.Unit.Exagram,
    petagram: SI.Unit.Petagram,
    teragram: SI.Unit.Teragram,
    gigagram: SI.Unit.Gigagram,
    megagram: SI.Unit.Megagram,
    kilogram: SI.Unit.Kilogram,
    hectogram: SI.Unit.Hectogram,
    decagram: SI.Unit.Decagram,
    decigram: SI.Unit.Decigram,
    centigram: SI.Unit.Centigram,
    milligram: SI.Unit.Milligram,
    microgram: SI.Unit.Microgram,
    nanogram: SI.Unit.Nanogram,
    picogram: SI.Unit.Picogram,
    femtogram: SI.Unit.Femtogram,
    attogram: SI.Unit.Attogram
  ]
]
```

### Prefixes

Every single basic unit by default has "prefixed" definitions.

#### Example for `SI.Unit.Gram`

| Module              | Name      | Symbol | Multiplier       | 
|---------------------|-----------|--------|------------------| 
| `SI.Unit.Exagram`   | exagram   | `Eg`   | 10<sup>18</sup>  |
| `SI.Unit.Petagram`  | petagram  | `Pg`   | 10<sup>15</sup>  |
| `SI.Unit.Teragram`  | teragram  | `Tg`   | 10<sup>12</sup>  |
| `SI.Unit.Gigagram`  | gigagram  | `Gg`   | 10<sup>9</sup>   |
| `SI.Unit.Megagram`  | megagram  | `Mg`   | 10<sup>6</sup>   |
| `SI.Unit.Kilogram`  | kilogram  | `kg`   | 10<sup>3</sup>   |
| `SI.Unit.Hectogram` | hectogram | `hg`   | 10<sup>2</sup>   |
| `SI.Unit.Decagram`  | decagram  | `dag`  | 10<sup>1</sup>   |
| `SI.Unit.Gram`      | gram      | `dag`  | 10<sup>0</sup>   |
| `SI.Unit.Decigram`  | decigram  | `dg`   | 10<sup>-1</sup>  |
| `SI.Unit.Centigram` | centigram | `cg`   | 10<sup>-2</sup>  |
| `SI.Unit.Milligram` | milligram | `mg`   | 10<sup>-3</sup>  |
| `SI.Unit.Microgram` | microgram | `ug`   | 10<sup>-6</sup>  |
| `SI.Unit.Nanogram`  | nanogram  | `ng`   | 10<sup>-9</sup>  |
| `SI.Unit.Picogram`  | picogram  | `pg`   | 10<sup>-12</sup> |
| `SI.Unit.Femtogram` | femtogram | `fg`   | 10<sup>-15</sup> |
| `SI.Unit.Attogram`  | attogram  | `ag`   | 10<sup>-18</sup> |

Every "prefixed" unit has been created using multiplier module

| Name  | Prefix | Multiplier | Module                |
|-------|--------|------------|-----------------------|  
| exa   | `E`    | 18         | `SI.Multiplier.Exa`   |
| peta  | `P`    | 15         | `SI.Multiplier.Peta`  |
| tera  | `T`    | 12         | `SI.Multiplier.Tera`  |
| giga  | `G`    | 9          | `SI.Multiplier.Giga`  |
| mega  | `M`    | 6          | `SI.Multiplier.Mega`  |
| kilo  | `k`    | 3          | `SI.Multiplier.Kilo`  |
| hecto | `h`    | 2          | `SI.Multiplier.Hecto` |
| deca  | `da`   | 1          | `SI.Multiplier.Deca`  |
| -     | -      | 0          | -                     |
| deci  | `d`    | -1         | `SI.Multiplier.Deci`  |
| centi | `c`    | -2         | `SI.Multiplier.Centi` |
| milli | `m`    | -3         | `SI.Multiplier.Milli` |
| micro | `u`    | -6         | `SI.Multiplier.Micro` |
| nano  | `n`    | -9         | `SI.Multiplier.Nano`  |
| pico  | `p`    | -12        | `SI.Multiplier.Pico`  |
| femto | `f`    | -15        | `SI.Multiplier.Femto` |
| atto  | `a`    | -18        | `SI.Multiplier.Atto`  |

## Docs

The docs can be found at [https://hexdocs.pm/si](https://hexdocs.pm/si).

## License

The `SI` is released under the Apache License 2.0 - see the [LICENSE](LICENSE) file.

