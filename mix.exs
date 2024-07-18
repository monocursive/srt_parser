defmodule SrtParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :srt_parser,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/monocursive/srt_parser",
      description: "Elixir package to parse SRT (subtitles) files",
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev, runtime: false}]
  end

  defp package do
    [
      maintainers: ["Monocursive"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/monocursive/srt_parser",
        "Monocurive Homepage" => "https://monocursive.com"
      },
      files: ["lib", "mix.exs", "README*", "LICENSE*", ".formatter.exs"]
    ]
  end

  defp docs do
    [
      extras: [
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: "https://github.com/monocursive/srt_parser",
      source_ref: "0.1.0",
      formatters: ["html"]
    ]
  end
end
