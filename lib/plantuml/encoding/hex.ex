defmodule Plantuml.Encoding.Hex do
  @moduledoc """
  Implements PlantUML's hex type text encoding.

  See [PlantUML's Documentation](https://plantuml.com/text-encoding) on text encoding.
  """

  @behaviour Plantuml.Encoding

  @impl Plantuml.Encoding
  @doc """
  Encodes `diagram` using hex method.
  """
  @spec encode(diagram :: String.t()) :: encoded_diagram :: String.t()
  def encode(diagram) do
    diagram
    |> String.to_charlist()
    |> Enum.map_join(&integer_to_hex/1)
  end

  @impl Plantuml.Encoding
  @doc """
  Decodes `encoded_diagram` thtat was encoded using hex method.
  """
  @spec decode(encoded_diagram :: String.t()) :: diagram :: String.t()
  def decode(encoded_diagram) do
    encoded_diagram
    |> String.to_charlist()
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_integer(&1, 16))
    |> List.to_string()
  end

  defp integer_to_hex(integer) when integer < 16, do: "0#{Integer.to_string(integer, 16)}"
  defp integer_to_hex(integer), do: Integer.to_string(integer, 16)
end
