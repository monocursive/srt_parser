# SrtParser

Elixir package to parse SRT (subtitles) files.

The goal was to be able to edit an SRT file from Elixir and save it back.

This library does not handle reading from a file, it only parses the content of a string.

[View documentation](https://github.com/elixir-lang/ex_doc)
## Installation

If [available in Hex](https://hexdocs.pm/srt_parser), the package can be installed
by adding `srt_parser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:srt_parser, "~> 0.1.0"}
  ]
end
```

## Usage

  Parse an SRT string:

  ```elixir
  iex> SrtParser.parse("1\\n00:00:00,000 --> 00:00:02,123\\nHello world\\n")
  {:ok, [
    %SrtParser.ParsedSubtitle{
      id: 1,
      start_time: 0,
      end_time: 2123,
      time_string: "00:00:00,000 --> 00:00:02,123",
      text: "Hello world"
    }
  ]}
  ```
  Get an SRT string from a list of ParsedSubtitle structs:

  ```elixir
  iex> SrtParser.to_srt!([%SrtParser.ParsedSubtitle{id: 1, start_time: 0, end_time: 2123, time_string: "00:00:00,000 --> 00:00:02,123", text: "Hello world"}])
  "1\\n00:00:00,000 --> 00:00:02,123\\nHello world"
  ```

  Example on how to read an SRT file and parse it:

  ```elixir
  iex> File.read!("example.srt") |> SrtParser.parse()
  ```

  ## Contributing
  Feel free to send a pull request if you have any improvements to the library.

  If you are considering to add a new feature, please create an issue first to discuss if the feature is a good fit for the project.

  I want to keep it minimal and focused, but I know srt files can have a lot of different formats, so I'm open to adding new features.

  ## License
  MIT
