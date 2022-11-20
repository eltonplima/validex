defmodule Validex.MixProject do
  use Mix.Project

  def project do
    [
      app: :validex,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Validex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_interactive, "~> 1.0", only: :dev, runtime: false},
      {:exiban, "~> 0.0.5"}
    ]
  end
end
