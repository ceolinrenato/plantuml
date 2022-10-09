defmodule Plantuml.Encoding.DeflateTest do
  use ExUnit.Case, async: true

  alias Plantuml.Encoding.Deflate

  describe "decode/1" do
    test "decodes a diagram encoded using Deflate" do
      # PlantUML's documentation example
      assert Deflate.decode(
               "Syp9J4vLqBLJSCfFib9mB2t9ICqhoKnEBCdCprC8IYqiJIqkuGBAAUW2rO0LOr5LN92VLvpA1G00"
             ) == "Alice -> Bob: Authentication Request\nBob --> Alice: Authentication Response\n"
    end
  end

  describe "encode/1" do
    test "encodes a diagram in a reversible way" do
      diagram = "Alice -> Bob: Authentication Request\nBob --> Alice: Authentication Response\n"
      encoded_diagram = Deflate.encode(diagram)

      assert Deflate.decode(encoded_diagram) == diagram
    end
  end
end
