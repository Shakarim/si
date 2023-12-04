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

  # GRAM
  derivative_modules = Unit.generate_derivative_list(Gram)
  formatted_derivative_modules = Enum.map(derivative_modules, fn {module, opts} -> {opts[:symbol], module} end)
  units = [{Gram.symbol(), Gram}] ++ formatted_derivative_modules
  Unit.compile_derivative_units(derivative_modules)
  @units {Mass.symbol(), units}
  # protocols
  multiplier_list = [{Gram, 0}] ++ Enum.map(derivative_modules, fn {module, opts} -> {module, opts[:multiplier].value} end)
  for {first, first_m} <- multiplier_list, {second, second_m} <- multiplier_list, into: [] do
    if (first !== second) do
      multiplier = 1/:math.pow(10, first_m - second_m)
      Unit.compile_protocol_impl(first, second, multiplier)
    end
  end

  # MOLE
  derivative_modules = Unit.generate_derivative_list(Mole)
  formatted_derivative_modules = Enum.map(derivative_modules, fn {module, opts} -> {opts[:symbol], module} end)
  units = [{Mole.symbol(), Mole}] ++ formatted_derivative_modules
  Unit.compile_derivative_units(derivative_modules)
  @units {AmountOfSubstance.symbol(), units}
  # protocols
  multiplier_list = [{Mole, 0}] ++ Enum.map(derivative_modules, fn {module, opts} -> {module, opts[:multiplier].value} end)
  for {first, first_m} <- multiplier_list, {second, second_m} <- multiplier_list, into: [] do
    if (first !== second) do
      multiplier = 1/:math.pow(10, first_m - second_m)
      Unit.compile_protocol_impl(first, second, multiplier)
    end
  end

  # AMPERE
  derivative_modules = Unit.generate_derivative_list(Ampere)
  formatted_derivative_modules = Enum.map(derivative_modules, fn {module, opts} -> {opts[:symbol], module} end)
  units = [{Ampere.symbol(), Ampere}] ++ formatted_derivative_modules
  Unit.compile_derivative_units(derivative_modules)
  @units {ElectricCurrent.symbol(), units}
  # protocols
  multiplier_list = [{Ampere, 0}] ++ Enum.map(derivative_modules, fn {module, opts} -> {module, opts[:multiplier].value} end)
  for {first, first_m} <- multiplier_list, {second, second_m} <- multiplier_list, into: [] do
    if (first !== second) do
      multiplier = 1/:math.pow(10, first_m - second_m)
      Unit.compile_protocol_impl(first, second, multiplier)
    end
  end

  # METER
  derivative_modules = Unit.generate_derivative_list(Meter)
  formatted_derivative_modules = Enum.map(derivative_modules, fn {module, opts} -> {opts[:symbol], module} end)
  units = [{Meter.symbol(), Meter}] ++ formatted_derivative_modules
  Unit.compile_derivative_units(derivative_modules)
  @units {Length.symbol(), units}
  # protocols
  multiplier_list = [{Meter, 0}] ++ Enum.map(derivative_modules, fn {module, opts} -> {module, opts[:multiplier].value} end)
  for {first, first_m} <- multiplier_list, {second, second_m} <- multiplier_list, into: [] do
    if (first !== second) do
      multiplier = 1/:math.pow(10, first_m - second_m)
      Unit.compile_protocol_impl(first, second, multiplier)
    end
  end

  # CANDELA
  derivative_modules = Unit.generate_derivative_list(Candela)
  formatted_derivative_modules = Enum.map(derivative_modules, fn {module, opts} -> {opts[:symbol], module} end)
  units = [{Candela.symbol(), Candela}] ++ formatted_derivative_modules
  Unit.compile_derivative_units(derivative_modules)
  @units {LuminousIntensity.symbol(), units}
  # protocols
  multiplier_list = [{Candela, 0}] ++ Enum.map(derivative_modules, fn {module, opts} -> {module, opts[:multiplier].value} end)
  for {first, first_m} <- multiplier_list, {second, second_m} <- multiplier_list, into: [] do
    if (first !== second) do
      multiplier = 1/:math.pow(10, first_m - second_m)
      Unit.compile_protocol_impl(first, second, multiplier)
    end
  end

  # KELVIN
  derivative_modules = Unit.generate_derivative_list(Kelvin)
  formatted_derivative_modules = Enum.map(derivative_modules, fn {module, opts} -> {opts[:symbol], module} end)
  units = [{Kelvin.symbol(), Kelvin}] ++ formatted_derivative_modules
  Unit.compile_derivative_units(derivative_modules)
  @units {ThermodynamicTemperature.symbol(), units}
  # protocols
  multiplier_list = [{Kelvin, 0}] ++ Enum.map(derivative_modules, fn {module, opts} -> {module, opts[:multiplier].value} end)
  for {first, first_m} <- multiplier_list, {second, second_m} <- multiplier_list, into: [] do
    if (first !== second) do
      multiplier = 1/:math.pow(10, first_m - second_m)
      Unit.compile_protocol_impl(first, second, multiplier)
    end
  end

  # SECOND
  derivative_modules = Unit.generate_derivative_list(Second)
  formatted_derivative_modules = Enum.map(derivative_modules, fn {module, opts} -> {opts[:symbol], module} end)
  units = [{Second.symbol(), Second}] ++ formatted_derivative_modules
  Unit.compile_derivative_units(derivative_modules)
  @units {Time.symbol(), units}
  # protocols
  multiplier_list = [{Second, 0}] ++ Enum.map(derivative_modules, fn {module, opts} -> {module, opts[:multiplier].value} end)
  for {first, first_m} <- multiplier_list, {second, second_m} <- multiplier_list, into: [] do
    if (first !== second) do
      multiplier = 1/:math.pow(10, first_m - second_m)
      Unit.compile_protocol_impl(first, second, multiplier)
    end
  end

  # === FUNCTIONS ===

  def quantities(), do: @basic_quantities
  def units(), do: @units
end
