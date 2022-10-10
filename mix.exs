defmodule Plantuml.MixProject do
  use Mix.Project

  def project do
    [
      name: "Plantuml",
      source_url: "https://github.com/ceolinrenato/plantuml",
      app: :plantuml,
      version: "0.1.0",
      elixir: ">= 1.12.3",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      package: package(),
      description: description()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    "PlantUML tooling for elixir. Autogenerate markdown links with embedded PlantUML diagrams"
  end

  defp package do
    [
      name: "plantuml",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ceolinrenato/plantuml"}
    ]
  end
end
