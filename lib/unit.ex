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

  defmacro compile_protocol_impl(module, for, multiplier) do
    quote do
      defimpl :"#{unquote(module)}.Converter", for: unquote(for) do
        @multiplier unquote(multiplier)
        @module unquote(module)
        def create(%_{value: value}), do: %{__struct__: @module, value: value * @multiplier}
      end
    end
  end

  defmacro compile_derivative_units(generating_units) do
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

  @spec generate_derivative_list(atom()) :: [{atom(), keyword()}]
  def generate_derivative_list(basic_module) do
    Enum.map(@multipliers, fn {_multiplier_symbol, multiplier_module} ->
      {
        unit_module_name(basic_module, multiplier_module),
        symbol: derivative_symbol(basic_module, multiplier_module),
        name: derivative_name(basic_module, multiplier_module),
        multiplier: multiplier_module,
        for: basic_module
      }
    end)
  end

  @spec derivative_symbol(atom(), atom()) :: atom()
  def derivative_symbol(original_module, multiplier_module), do: :"#{multiplier_module.symbol()}#{original_module.symbol()}"

  @spec derivative_name(atom(), atom()) :: binary()
  def derivative_name(original_module, multiplier_module), do: "#{multiplier_module.name()}#{original_module.name()}"

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
