defmodule SI.MixProject do
  use Mix.Project

  def project do
    [
      app: :si,
      name: "SI",
      version: "1.0.0",
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
    The library, implements modules and structs for work with SI system.

    The International System of Units, internationally known by the abbreviation SI (from French Système International), is the modern form of the metric system and the world's most widely used system of measurement. Established and maintained by the General Conference on Weights and Measures, it is the only system of measurement with an official status in nearly every country in the world, employed in science, technology, industry, and everyday commerce.
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
