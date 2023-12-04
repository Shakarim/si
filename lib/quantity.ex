defmodule SI.Quantity do
  @moduledoc false

  defmacro __using__(opts) do
    name = opts[:name] || raise("the `name` is required option")
    symbol = opts[:symbol] || raise("the `symbol` is required option")
    unit = opts[:unit] || raise("the `unit` is required option")

    quote do
      Module.put_attribute(__MODULE__, :name, unquote(name))
      Module.put_attribute(__MODULE__, :symbol, unquote(symbol))
      Module.put_attribute(__MODULE__, :unit, unquote(unit))

      def name, do: @name

      def symbol, do: @symbol

      def unit, do: @unit
    end
  end
end
