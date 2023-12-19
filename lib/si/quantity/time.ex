defmodule SI.Quantity.Time do
  @moduledoc false

  use SI.Quantity,
      name: "time",
      symbol: "t",
      unit: SI.Unit.Second
end
