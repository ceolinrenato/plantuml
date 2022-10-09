defmodule Plantuml.Encoding.HexTest do
  use ExUnit.Case, async: true
  alias Plantuml.Encoding.Hex

  describe "decode/1" do
    test "decodes a diagram encoded using Hex" do
      # PlantUML's documentation example

      assert Hex.decode(
               "407374617274756d6c0a416c6963652d3e426f62203a204920616d207573696e67206865780a40656e64756d6c"
             ) == "@startuml\nAlice->Bob : I am using hex\n@enduml"
    end
  end

  describe "encode/1" do
    test "encodes a diagram in a reversible way" do
      diagram = "Alice -> Bob: Authentication Request\nBob --> Alice: Authentication Response\n"
      encoded_diagram = Hex.encode(diagram)

      assert Hex.decode(encoded_diagram) == diagram
    end
  end
end
