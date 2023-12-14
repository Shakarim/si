defmodule SI.Multiplier do
  @moduledoc false

  defmacro __using__(opts) do
    name = opts[:name] || raise("the `name` is required option")
    symbol = opts[:symbol] || raise("the `symbol` is required option")
    value = opts[:value] || raise("the `value` is required option")

    quote do
      Module.put_attribute(__MODULE__, :name, unquote(name))
      Module.put_attribute(__MODULE__, :symbol, unquote(symbol))
      Module.put_attribute(__MODULE__, :value, unquote(value))

      def name, do: @name

      def symbol, do: @symbol

      def value, do: @value
    end
  end
end
