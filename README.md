# Si

The library implements quantities and units which included to basic SI.

The **[International System of Units](https://en.wikipedia.org/wiki/International_System_of_Units)**, internationally known by the abbreviation SI (from French Système International), is the modern form of the [metric system](https://en.wikipedia.org/wiki/Metric_system) and the world's most widely used [system of measurement](https://en.wikipedia.org/wiki/System_of_measurement). Established and maintained by the [General Conference on Weights and Measures](https://en.wikipedia.org/wiki/General_Conference_on_Weights_and_Measures), it is the only system of measurement with an official status in nearly every country in the world, employed in science, technology, industry, and everyday commerce.

## Installation

If [available in Hex](https://hex.pm/packages/si), the package can be installed
by adding `si` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:si, "~> 1.4"}
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
| ampere  | `:A`   | `SI.Unit.Ampere`   |
| candela | `:cd`  | `SI.Unit.Candela`  |
| gram    | `:g`   | `SI.Unit.Gram`     |
| kelvin  | `:K`   | `SI.Unit.Kelvin`   |
| meter   | `:m`   | `SI.Unit.Meter`    |
| mole    | `:mol` | `SI.Unit.Mole`     |
| second  | `:s`   | `SI.Unit.Second`   |

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
    s: SI.Unit.Second,
    Es: SI.Unit.Exasecond,
    Ps: SI.Unit.Petasecond,
    Ts: SI.Unit.Terasecond,
    Gs: SI.Unit.Gigasecond,
    Ms: SI.Unit.Megasecond,
    ks: SI.Unit.Kilosecond,
    hs: SI.Unit.Hectosecond,
    das: SI.Unit.Decasecond,
    ds: SI.Unit.Decisecond,
    cs: SI.Unit.Centisecond,
    ms: SI.Unit.Millisecond,
    us: SI.Unit.Microsecond,
    ns: SI.Unit.Nanosecond,
    ps: SI.Unit.Picosecond,
    fs: SI.Unit.Femtosecond,
    as: SI.Unit.Attosecond
  ],
  thermodynamic_temperature: [
    K: SI.Unit.Kelvin,
    EK: SI.Unit.Exakelvin,
    PK: SI.Unit.Petakelvin,
    TK: SI.Unit.Terakelvin,
    GK: SI.Unit.Gigakelvin,
    MK: SI.Unit.Megakelvin,
    kK: SI.Unit.Kilokelvin,
    hK: SI.Unit.Hectokelvin,
    daK: SI.Unit.Decakelvin,
    dK: SI.Unit.Decikelvin,
    cK: SI.Unit.Centikelvin,
    mK: SI.Unit.Millikelvin,
    uK: SI.Unit.Microkelvin,
    nK: SI.Unit.Nanokelvin,
    pK: SI.Unit.Picokelvin,
    fK: SI.Unit.Femtokelvin,
    aK: SI.Unit.Attokelvin
  ],
  luminous_intensity: [
    cd: SI.Unit.Candela,
    Ecd: SI.Unit.Exacandela,
    Pcd: SI.Unit.Petacandela,
    Tcd: SI.Unit.Teracandela,
    Gcd: SI.Unit.Gigacandela,
    Mcd: SI.Unit.Megacandela,
    kcd: SI.Unit.Kilocandela,
    hcd: SI.Unit.Hectocandela,
    dacd: SI.Unit.Decacandela,
    dcd: SI.Unit.Decicandela,
    ccd: SI.Unit.Centicandela,
    mcd: SI.Unit.Millicandela,
    ucd: SI.Unit.Microcandela,
    ncd: SI.Unit.Nanocandela,
    pcd: SI.Unit.Picocandela,
    fcd: SI.Unit.Femtocandela,
    acd: SI.Unit.Attocandela
  ],
  length: [
    m: SI.Unit.Meter,
    Em: SI.Unit.Exameter,
    Pm: SI.Unit.Petameter,
    Tm: SI.Unit.Terameter,
    Gm: SI.Unit.Gigameter,
    Mm: SI.Unit.Megameter,
    km: SI.Unit.Kilometer,
    hm: SI.Unit.Hectometer,
    dam: SI.Unit.Decameter,
    dm: SI.Unit.Decimeter,
    cm: SI.Unit.Centimeter,
    mm: SI.Unit.Millimeter,
    um: SI.Unit.Micrometer,
    nm: SI.Unit.Nanometer,
    pm: SI.Unit.Picometer,
    fm: SI.Unit.Femtometer,
    am: SI.Unit.Attometer
  ],
  electric_current: [
    A: SI.Unit.Ampere,
    EA: SI.Unit.Exaampere,
    PA: SI.Unit.Petaampere,
    TA: SI.Unit.Teraampere,
    GA: SI.Unit.Gigaampere,
    MA: SI.Unit.Megaampere,
    kA: SI.Unit.Kiloampere,
    hA: SI.Unit.Hectoampere,
    daA: SI.Unit.Decaampere,
    dA: SI.Unit.Deciampere,
    cA: SI.Unit.Centiampere,
    mA: SI.Unit.Milliampere,
    uA: SI.Unit.Microampere,
    nA: SI.Unit.Nanoampere,
    pA: SI.Unit.Picoampere,
    fA: SI.Unit.Femtoampere,
    aA: SI.Unit.Attoampere
  ],
  amount_of_substance: [
    mol: SI.Unit.Mole,
    Emol: SI.Unit.Examole,
    Pmol: SI.Unit.Petamole,
    Tmol: SI.Unit.Teramole,
    Gmol: SI.Unit.Gigamole,
    Mmol: SI.Unit.Megamole,
    kmol: SI.Unit.Kilomole,
    hmol: SI.Unit.Hectomole,
    damol: SI.Unit.Decamole,
    dmol: SI.Unit.Decimole,
    cmol: SI.Unit.Centimole,
    mmol: SI.Unit.Millimole,
    umol: SI.Unit.Micromole,
    nmol: SI.Unit.Nanomole,
    pmol: SI.Unit.Picomole,
    fmol: SI.Unit.Femtomole,
    amol: SI.Unit.Attomole
  ],
  mass: [
    g: SI.Unit.Gram,
    Eg: SI.Unit.Exagram,
    Pg: SI.Unit.Petagram,
    Tg: SI.Unit.Teragram,
    Gg: SI.Unit.Gigagram,
    Mg: SI.Unit.Megagram,
    kg: SI.Unit.Kilogram,
    hg: SI.Unit.Hectogram,
    dag: SI.Unit.Decagram,
    dg: SI.Unit.Decigram,
    cg: SI.Unit.Centigram,
    mg: SI.Unit.Milligram,
    ug: SI.Unit.Microgram,
    ng: SI.Unit.Nanogram,
    pg: SI.Unit.Picogram,
    fg: SI.Unit.Femtogram,
    ag: SI.Unit.Attogram
  ]
]
```

### Prefixes

Every single basic unit by default has "prefixed" definitions.

#### Example for `SI.Unit.Gram`

| Module              | Name      | Symbol | Multiplier       | 
|---------------------|-----------|--------|------------------| 
| `SI.Unit.Exagram`   | exagram   | `:Eg`  | 10<sup>18</sup>  |
| `SI.Unit.Petagram`  | petagram  | `:Pg`  | 10<sup>15</sup>  |
| `SI.Unit.Teragram`  | teragram  | `:Tg`  | 10<sup>12</sup>  |
| `SI.Unit.Gigagram`  | gigagram  | `:Gg`  | 10<sup>9</sup>   |
| `SI.Unit.Megagram`  | megagram  | `:Mg`  | 10<sup>6</sup>   |
| `SI.Unit.Kilogram`  | kilogram  | `:kg`  | 10<sup>3</sup>   |
| `SI.Unit.Hectogram` | hectogram | `:hg`  | 10<sup>2</sup>   |
| `SI.Unit.Decagram`  | decagram  | `:dag` | 10<sup>1</sup>   |
| `SI.Unit.Gram`      | gram      | `:dag` | 10<sup>0</sup>   |
| `SI.Unit.Decigram`  | decigram  | `:dg`  | 10<sup>-1</sup>  |
| `SI.Unit.Centigram` | centigram | `:cg`  | 10<sup>-2</sup>  |
| `SI.Unit.Milligram` | milligram | `:mg`  | 10<sup>-3</sup>  |
| `SI.Unit.Microgram` | microgram | `:ug`  | 10<sup>-6</sup>  |
| `SI.Unit.Nanogram`  | nanogram  | `:ng`  | 10<sup>-9</sup>  |
| `SI.Unit.Picogram`  | picogram  | `:pg`  | 10<sup>-12</sup> |
| `SI.Unit.Femtogram` | femtogram | `:fg`  | 10<sup>-15</sup> |
| `SI.Unit.Attogram`  | attogram  | `:ag`  | 10<sup>-18</sup> |

Every "prefixed" unit has been created using multiplier module

| Name  | Prefix | Multiplier | Module                |
|-------|--------|------------|-----------------------|  
| exa   | `:E`   | 18         | `SI.Multiplier.Exa`   |
| peta  | `:P`   | 15         | `SI.Multiplier.Peta`  |
| tera  | `:T`   | 12         | `SI.Multiplier.Tera`  |
| giga  | `:G`   | 9          | `SI.Multiplier.Giga`  |
| mega  | `:M`   | 6          | `SI.Multiplier.Mega`  |
| kilo  | `:k`   | 3          | `SI.Multiplier.Kilo`  |
| hecto | `:h`   | 2          | `SI.Multiplier.Hecto` |
| deca  | `:da`  | 1          | `SI.Multiplier.Deca`  |
| -     | -      | 0          | -                     |
| deci  | `:d`   | -1         | `SI.Multiplier.Deci`  |
| centi | `:c`   | -2         | `SI.Multiplier.Centi` |
| milli | `:m`   | -3         | `SI.Multiplier.Milli` |
| micro | `:u`   | -6         | `SI.Multiplier.Micro` |
| nano  | `:n`   | -9         | `SI.Multiplier.Nano`  |
| pico  | `:p`   | -12        | `SI.Multiplier.Pico`  |
| femto | `:f`   | -15        | `SI.Multiplier.Femto` |
| atto  | `:a`   | -18        | `SI.Multiplier.Atto`  |

## Docs

The docs can be found at [https://hexdocs.pm/si](https://hexdocs.pm/si).

## License

The `SI` is released under the Apache License 2.0 - see the [LICENSE](LICENSE) file.

