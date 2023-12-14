defmodule SI do
  @moduledoc """
  Documentation for SI.
  """

  alias SI.Quantity
  alias SI.Unit

  alias Quantity.Mass
  alias Quantity.AmountOfSubstance
  alias Quantity.Time
  alias Quantity.ThermodynamicTemperature
  alias Quantity.LuminousIntensity
  alias Quantity.Length
  alias Quantity.ElectricCurrent

  alias Unit.{Gram, Mole, Ampere, Meter, Candela, Kelvin, Second}

  require Unit

  Module.register_attribute(__MODULE__, :units, accumulate: true)

  @basic_quantities [
    {Mass.symbol(), Mass},
    {AmountOfSubstance.symbol(), AmountOfSubstance},
    {Time.symbol(), Time},
    {ThermodynamicTemperature.symbol(), ThermodynamicTemperature},
    {LuminousIntensity.symbol(), LuminousIntensity},
    {Length.symbol(), Length},
    {ElectricCurrent.symbol(), ElectricCurrent}
  ]

  # === UNITS ===
  @units {Mass.symbol(), Unit.generate_module_variations(Gram)}
  Unit.compile_derivative_units(Gram)
  Unit.compile_variation_conversions(Gram)

  @units {AmountOfSubstance.symbol(), Unit.generate_module_variations(Mole)}
  Unit.compile_derivative_units(Mole)
  Unit.compile_variation_conversions(Mole)

  @units {ElectricCurrent.symbol(), Unit.generate_module_variations(Ampere)}
  Unit.compile_derivative_units(Ampere)
  Unit.compile_variation_conversions(Ampere)

  @units {Length.symbol(), Unit.generate_module_variations(Meter)}
  Unit.compile_derivative_units(Meter)
  Unit.compile_variation_conversions(Meter)

  @units {LuminousIntensity.symbol(), Unit.generate_module_variations(Candela)}
  Unit.compile_derivative_units(Candela)
  Unit.compile_variation_conversions(Candela)

  @units {ThermodynamicTemperature.symbol(), Unit.generate_module_variations(Kelvin)}
  Unit.compile_derivative_units(Kelvin)
  Unit.compile_variation_conversions(Kelvin)

  @units {Time.symbol(), Unit.generate_module_variations(Second)}
  Unit.compile_derivative_units(Second)
  Unit.compile_variation_conversions(Second)

  # === FUNCTIONS ===

  def quantities(), do: @basic_quantities
  def units(), do: @units
end
