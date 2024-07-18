defmodule SrtParser do
  @moduledoc """
  Documentation for `SrtParser`.
  It provides a function to parse srt strings into a list of `ParsedSubtitle` structs.
  """

  @doc """
  Parse the given srt string into a tuple containing :ok and a list of `ParsedSubtitle` structs or a tuple with error and the error message. Start and end times are converted to milliseconds.

  ## Example
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
  """
  def parse(srt) do
    try do
      {:ok,
       srt
       |> String.split("\n\n", trim: true)
       |> Enum.map(&parse_subtitle!/1)}
    rescue
      _ -> {:error, "Invalid srt"}
    end
  end

  @doc """
  Parse the given srt string into a tuple containing :ok and a list of `ParsedSubtitle` structs or a tuple with error and the error message. Start and end times are converted to milliseconds.

  ## Example
    iex> SrtParser.to_srt!([%SrtParser.ParsedSubtitle{id: 1, start_time: 0, end_time: 2123, time_string: "00:00:00,000 --> 00:00:02,123", text: "Hello world"}])
    "1\\n00:00:00,000 --> 00:00:02,123\\nHello world"

  """
  def to_srt!(parsed_subtitle) do
    parsed_subtitle
    |> Enum.map(&to_srt_subtitle!/1)
    |> Enum.join("\n\n")
  end

  defp to_srt_subtitle!(%SrtParser.ParsedSubtitle{
         id: id,
         time_string: time_string,
         text: text
       }) do
    "#{id}\n#{time_string}\n#{text}"
  end

  defp parse_subtitle!(subtitle) do
    [id, time, text] = String.split(subtitle, "\n", trim: true)
    [start_time, end_time] = String.split(time, " --> ", trim: true)

    if is_nil(id) || is_nil(start_time) || is_nil(end_time) || is_nil(text) do
      raise "Invalid subtitle"
    end

    %SrtParser.ParsedSubtitle{
      id: String.to_integer(id),
      time_string: time,
      start_time: parse_time(start_time),
      end_time: parse_time(end_time),
      text: text
    }
  end

  defp parse_time(time) do
    [hours, minutes, seconds] = String.split(time, ":", trim: true)
    [seconds, milliseconds] = String.split(seconds, ",", trim: true)

    hours = String.to_integer(hours)
    minutes = String.to_integer(minutes)
    seconds = String.to_integer(seconds)
    milliseconds = String.to_integer(milliseconds)

    (hours * 3600 + minutes * 60 + seconds) * 1000 + milliseconds
  end
end
