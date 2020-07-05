defmodule Hoover.MixProject do
  use Mix.Project

  def project do
    [
      app: :hoover,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Hoover.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:csv, "~> 2.3"},
      {:plug, "~> 1.10"},
      {:plug_cowboy, "~> 2.3"},
      {:exsync, "~> 0.2", only: :dev},
      {:credo, "~> 1.4", only: :dev, runttime: false},
      {:dialyxir, "~> 1.0.0", only: :dev, runtime: false},
      {:git_hooks, "~> 0.4.2", only: [:test, :dev], runtime: false},
      {:excoveralls, "~> 0.13", only: :test}
    ]
  end
end
