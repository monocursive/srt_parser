defmodule SrtParserTest do
  use ExUnit.Case
  doctest SrtParser

  test "parse valid srt" do
    srt = """
    1
    00:00:00,000 --> 00:00:02,123
    Hello world

    2
    00:00:02,123 --> 00:00:04,123
    Existing world

    3
    00:00:04,123 --> 00:00:06,123
    Goodbye world

    """

    assert SrtParser.parse(srt) ==
             {:ok,
              [
                %SrtParser.ParsedSubtitle{
                  id: 1,
                  time_string: "00:00:00,000 --> 00:00:02,123",
                  start_time: 0,
                  end_time: 2123,
                  text: "Hello world"
                },
                %SrtParser.ParsedSubtitle{
                  id: 2,
                  time_string: "00:00:02,123 --> 00:00:04,123",
                  start_time: 2123,
                  end_time: 4123,
                  text: "Existing world"
                },
                %SrtParser.ParsedSubtitle{
                  id: 3,
                  time_string: "00:00:04,123 --> 00:00:06,123",
                  start_time: 4123,
                  end_time: 6123,
                  text: "Goodbye world"
                }
              ]}
  end

  test "error on invalid srt" do
    srt = """
    1
    Hello world

    2
    00:00:02,123 --> 00:00:04,123

    00:00:04,123 --> 00:00:06,123
    Subtitles provided by MONOCURSIVEXxXxX team

    """

    assert SrtParser.parse(srt) == {:error, "Invalid srt"}
  end
end
