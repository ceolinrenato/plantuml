defmodule Plantuml.Encoding do
  @moduledoc """
  This module provides functions to encode/decode PlantUML's diagrams.

  See [PlantUML's Documentation](https://plantuml.com/text-encoding) on text encoding.
  """

  @callback encode(diagram :: String.t()) :: encoded_diagram :: String.t()
  @callback decode(encoded_diagram :: String.t()) :: decoded_diagram :: String.t()

  @doc """
  Encodes a diagram.

  ## Options:
  * `:method` - the encoding method, can be either `:deflate` or `:hex`. Defaults to `:deflate`

  ## Examples:
  iex> Plantuml.Encoding.encode("Alice -> Bob: Authentication Request\\nBob --> Alice: Authentication Response\\n")
  "Syp9J4vLqBLJSCfFib9mB2t9ICqhoKnEBCdCprC8IYqiJIqkuGBAAUW2rJY256DHLLoGdrUSoWK0"

  iex> Plantuml.Encoding.encode("Alice -> Bob: Authentication Request\\nBob --> Alice: Authentication Response\\n", method: :hex)
  "416C696365202D3E20426F623A2041757468656E7469636174696F6E20526571756573740A426F62202D2D3E20416C6963653A2041757468656E7469636174696F6E20526573706F6E73650A"
  """
  @spec encode(diagram :: String.t(), opts :: keyword()) :: encoded_diagram :: String.t()
  def encode(diagram, opts \\ []),
    do: encoding_method_module(Keyword.get(opts, :method, :deflate)).encode(diagram)

  @doc """
  Decodes an encoded diagram.

  ## Options:
  * `:method` - the encoding method, can be either `:deflate` or `:hex`. Defaults to `:deflate`

  ## Examples:
  iex> Plantuml.Encoding.decode("Syp9J4vLqBLJSCfFib9mB2t9ICqhoKnEBCdCprC8IYqiJIqkuGBAAUW2rJY256DHLLoGdrUSoWK0")
  "Alice -> Bob: Authentication Request\\nBob --> Alice: Authentication Response\\n"

  iex> Plantuml.Encoding.decode("416C696365202D3E20426F623A2041757468656E7469636174696F6E20526571756573740A426F62202D2D3E20416C6963653A2041757468656E7469636174696F6E20526573706F6E73650A", method: :hex)
  "Alice -> Bob: Authentication Request\\nBob --> Alice: Authentication Response\\n"
  """
  @spec decode(encoded_diagram :: String.t(), opts :: keyword()) :: diagram :: String.t()
  def decode(encoded_diagram, opts \\ []),
    do: encoding_method_module(Keyword.get(opts, :method, :deflate)).decode(encoded_diagram)

  defp encoding_method_module(:hex), do: Plantuml.Encoding.Hex
  defp encoding_method_module(:deflate), do: Plantuml.Encoding.Deflate
end
