defmodule TravisRelease.MixProject do
  use Mix.Project

  def project do
    [
      app: :travis_release,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {TravisRelease.Application, []}
    ]
  end

  defp deps do
    [
      {:distillery, "~> 2.0"}
    ]
  end
end
