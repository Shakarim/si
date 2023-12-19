defmodule SI do
  @moduledoc """
  Documentation for SI.
  """

  alias SI.Quantity
  alias SI.Unit

  alias Quantity.{Mass, AmountOfSubstance, Time, ThermodynamicTemperature, LuminousIntensity, Length, ElectricCurrent}
  alias Unit.{Gram, Mole, Ampere, Meter, Candela, Kelvin, Second}

  require Unit

  Module.register_attribute(__MODULE__, :units, accumulate: true)

  @basic_quantities [
    {Mass.name_atom(), Mass},
    {AmountOfSubstance.name_atom(), AmountOfSubstance},
    {Time.name_atom(), Time},
    {ThermodynamicTemperature.name_atom(), ThermodynamicTemperature},
    {LuminousIntensity.name_atom(), LuminousIntensity},
    {Length.name_atom(), Length},
    {ElectricCurrent.name_atom(), ElectricCurrent}
  ]

  # === UNITS ===
  @units {Mass.name_atom(), Unit.generate_module_variations(Gram)}
  Unit.compile_derivative_units(Gram)
  Unit.compile_variation_conversions(Gram)

  @units {AmountOfSubstance.name_atom(), Unit.generate_module_variations(Mole)}
  Unit.compile_derivative_units(Mole)
  Unit.compile_variation_conversions(Mole)

  @units {ElectricCurrent.name_atom(), Unit.generate_module_variations(Ampere)}
  Unit.compile_derivative_units(Ampere)
  Unit.compile_variation_conversions(Ampere)

  @units {Length.name_atom(), Unit.generate_module_variations(Meter)}
  Unit.compile_derivative_units(Meter)
  Unit.compile_variation_conversions(Meter)

  @units {LuminousIntensity.name_atom(), Unit.generate_module_variations(Candela)}
  Unit.compile_derivative_units(Candela)
  Unit.compile_variation_conversions(Candela)

  @units {ThermodynamicTemperature.name_atom(), Unit.generate_module_variations(Kelvin)}
  Unit.compile_derivative_units(Kelvin)
  Unit.compile_variation_conversions(Kelvin)

  @units {Time.name_atom(), Unit.generate_module_variations(Second)}
  Unit.compile_derivative_units(Second)
  Unit.compile_variation_conversions(Second)

  # === FUNCTIONS ===

  def quantities(), do: @basic_quantities
  def units(), do: @units
end
