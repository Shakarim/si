defmodule SI.MixProject do
  use Mix.Project

  def project do
    [
      app: :si,
      name: "SI",
      version: "1.1.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/Shakarim/si"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    ~S"""
    The library, implements modules and structs for work with `The International System of Units`.
    """
  end

  defp package() do
    [
      maintainers: ["Shakarim Sapa"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/Shakarim/si"}
    ]
  end
end
