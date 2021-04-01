defmodule StoneChallengeHttp.MixProject do
  use Mix.Project

  def project do
    [
      app: :stone_challenge_http,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {StoneChallengeHttp.Application, []}
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.11"},
      {:plug_cowboy, "~> 2.4"},
      {:jason, "~> 1.2"}
    ]
  end
end
