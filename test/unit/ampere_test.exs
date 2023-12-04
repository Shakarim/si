defmodule SI.Unit.AmpereTest do
  use ExUnit.Case
  alias SI.Unit.Gram
  alias SI.Unit.Ampere
  alias SI.Unit.Exaampere
  alias SI.Unit.Petaampere
  alias SI.Unit.Teraampere
  alias SI.Unit.Gigaampere
  alias SI.Unit.Megaampere
  alias SI.Unit.Kiloampere
  alias SI.Unit.Hectoampere
  alias SI.Unit.Decaampere
  alias SI.Unit.Deciampere
  alias SI.Unit.Centiampere
  alias SI.Unit.Milliampere
  alias SI.Unit.Microampere
  alias SI.Unit.Nanoampere
  alias SI.Unit.Picoampere
  alias SI.Unit.Femtoampere
  alias SI.Unit.Attoampere
  doctest Ampere

  test "`name/0` for integer" do
    name = Ampere.name()

    assert name === "ampere"
  end

  test "`symbol/0` for integer" do
    symbol = Ampere.symbol()

    assert symbol === :A
  end

  test "`create/1` for integer" do
    unit = Ampere.create(123)

    assert unit === %Ampere{value: 123.0}
  end

  test "`create/1` for float" do
    unit = Ampere.create(123.12)

    assert unit === %Ampere{value: 123.12}
  end

  test "`create/1` for `Exaampere`" do
    basic = Exaampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1.2339999999999998e20}
  end

  test "`create/1` for `Petaampere`" do
    basic = Petaampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1.2339999999999998e17}
  end

  test "`create/1` for `Teraampere`" do
    basic = Teraampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 123400000000000.0}
  end

  test "`create/1` for `Gigaampere`" do
    basic = Gigaampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 123399999999.99998}
  end

  test "`create/1` for `Megaampere`" do
    basic = Megaampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 123400000.0}
  end

  test "`create/1` for `Kiloampere`" do
    basic = Kiloampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 123400.0}
  end

  test "`create/1` for `Hectoampere`" do
    basic = Hectoampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 12340.0}
  end

  test "`create/1` for `Decaampere`" do
    basic = Decaampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1234.0}
  end

  test "`create/1` for `Deciampere`" do
    basic = Deciampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 12.340000000000002}
  end

  test "`create/1` for `Centiampere`" do
    basic = Centiampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1.234}
  end

  test "`create/1` for `Milliampere`" do
    basic = Milliampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 0.12340000000000001}
  end

  test "`create/1` for `Microampere`" do
    basic = Microampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1.234e-4}
  end

  test "`create/1` for `Nanoampere`" do
    basic = Nanoampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1.234e-7}
  end

  test "`create/1` for `Picoampere`" do
    basic = Picoampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1.234e-10}
  end

  test "`create/1` for `Femtoampere`" do
    basic = Femtoampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1.234e-13}
  end

  test "`create/1` for `Attoampere`" do
    basic = Attoampere.create(123.4)
    unit = Ampere.create(basic)

    assert unit === %Ampere{value: 1.2340000000000002e-16}
  end

  test "`create/1` for invalid type" do
    basic = Gram.create(123.4)

    assert_raise Protocol.UndefinedError, fn ->
      Ampere.create(basic)
    end
  end
end