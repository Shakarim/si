defmodule SI.Unit do
  @moduledoc false

  alias SI.Multiplier.{Exa,
                       Peta,
                       Tera,
                       Giga,
                       Mega,
                       Kilo,
                       Hecto,
                       Deca,
                       Deci,
                       Centi,
                       Milli,
                       Micro,
                       Nano,
                       Pico,
                       Femto,
                       Atto}

  @callback create(number()) :: term()

  @multipliers [
    {Exa.symbol(), Exa},
    {Peta.symbol(), Peta},
    {Tera.symbol(), Tera},
    {Giga.symbol(), Giga},
    {Mega.symbol(), Mega},
    {Kilo.symbol(), Kilo},
    {Hecto.symbol(), Hecto},
    {Deca.symbol(), Deca},
    {Deci.symbol(), Deci},
    {Centi.symbol(), Centi},
    {Milli.symbol(), Milli},
    {Micro.symbol(), Micro},
    {Nano.symbol(), Nano},
    {Pico.symbol(), Pico},
    {Femto.symbol(), Femto},
    {Atto.symbol(), Atto},
  ]

  defmacro __using__(opts) do
    name = opts[:name] || raise("the `name` is required option")
    symbol = opts[:symbol] || raise("the `symbol` is required option")

    quote do
      module = __MODULE__
      Module.put_attribute(__MODULE__, :name, unquote(name))
      Module.put_attribute(__MODULE__, :symbol, unquote(symbol))

      @behaviour SI.Unit

      @enforce_keys [:value]
      defstruct [value: nil]

      defprotocol Converter, do: Protocol.def(create(term))
      defimpl Converter, for: Float do
        @module module
        def create(term), do: %{__struct__: @module, value: term}
      end
      defimpl Converter, for: Integer do
        @module module
        def create(term), do: %{__struct__: @module, value: term/1}
      end

      @spec name() :: binary()
      def name, do: @name

      @spec symbol() :: atom()
      def symbol, do: @symbol

      @spec create(term()) :: term()
      def create(from), do: __MODULE__.Converter.create(from)
    end
  end

  defmacro compile_variation_conversions(arg) do
    base_module = Macro.expand(arg, __CALLER__)
    basic_unit = [{base_module, 0}]
    derivative_units = Enum.map(
      @multipliers,
      fn {_multiplier_symbol, multiplier_module} ->
        module = unit_module_name(base_module, multiplier_module)
        {module, multiplier_module.value}
      end
    )
    conversion_data = basic_unit ++ derivative_units

    quote do
      for {first, first_m} <- unquote(conversion_data), {second, second_m} <- unquote(conversion_data), into: [] do
        if (first !== second) do
          multiplier = 1/:math.pow(10, first_m - second_m)

          defimpl :"#{first}.Converter", for: second do
            @multiplier multiplier
            @module first
            def create(%_{value: value}), do: %{__struct__: @module, value: value * @multiplier}
          end
        end
      end
    end
  end

  defmacro compile_derivative_units(arg) do
    base_module = Macro.expand(arg, __CALLER__)
    generating_units = Enum.map(
      @multipliers,
      fn {_multiplier_symbol, multiplier_module} ->
        {
          unit_module_name(base_module, multiplier_module),
          symbol: derivative_symbol(base_module, multiplier_module),
          name: derivative_name(base_module, multiplier_module)
        }
      end
    )
    quote do
      Enum.map(
        unquote(generating_units),
        fn {module_name, opts} ->
          defmodule module_name do
            alias SI.Unit
            use Unit,
                name: opts[:name],
                symbol: opts[:symbol]
          end
        end
      )
    end
  end

  @spec generate_module_variations(atom()) :: [{symbol :: atom(), module :: atom()}]
  def generate_module_variations(basic_module) do
    basic = [{basic_module.symbol(), basic_module}]
    derivatives = Enum.map(@multipliers, fn {_multiplier_symbol, multiplier_module} ->
      {
        derivative_symbol(basic_module, multiplier_module),
        unit_module_name(basic_module, multiplier_module)
      }
    end)

    basic ++ derivatives
  end


  @spec derivative_symbol(atom(), atom()) :: atom()
  defp derivative_symbol(original_module, multiplier_module), do: :"#{multiplier_module.symbol()}#{original_module.symbol()}"

  @spec derivative_name(atom(), atom()) :: binary()
  defp derivative_name(original_module, multiplier_module), do: "#{multiplier_module.name()}#{original_module.name()}"

  @spec unit_module_name(atom(), atom()) :: atom()
  defp unit_module_name(original_module, multiplier_module)
      when is_atom(original_module) and is_atom(multiplier_module) do
    # Example for main module `Measurement.SI.Unit.Gram` and multiplier `Measurement.SI.Multiplier.Kilo`
    Module.split(original_module) # => ["Elixir", "Measurement", "SI", "Unit", "Gram"]
    |> Enum.reverse() # => ["Gram", "Unit", "SI", "Measurement", "Elixir"]
    |> (
         fn [name | tail] -> # => ["Gram", ["Unit", "SI", "Measurement", "Elixir"]]
           [
             Module.split(multiplier_module) # => ["Elixir", "Measurement", "SI", "Multiplier", "Kilo"]
             |> List.last() # => "Kilo"
             |> Kernel.<>(String.downcase("#{name}")) # => "Kilogram"
           ] ++ tail # => ["Kilogram", "Unit", "SI", "Measurement", "Elixir"]
         end).()
    |> Enum.reverse() # => ["Elixir", "Measurement", "SI", "Unit", "Kilogram"]
    |> Module.concat()
  end
  def unit_module_name(module_name) when is_atom(module_name), do: module_name
end
