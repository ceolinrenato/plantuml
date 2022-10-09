defmodule Plantuml.Encoding.Deflate do
  @moduledoc """
  Implements PlantUML's deflate type text encoding.

  See [PlantUML's Documentation](https://plantuml.com/text-encoding) on text encoding.
  """

  @behaviour Plantuml.Encoding

  @base64_mapping 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  @plantuml_mapping '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_'

  @impl Plantuml.Encoding
  def encode(diagram) do
    diagram
    |> :zlib.zip()
    |> Base.encode64(padding: false)
    |> translate(@base64_mapping, @plantuml_mapping)
  end

  @impl Plantuml.Encoding
  def decode(encoded_diagram) do
    encoded_diagram
    |> translate(@plantuml_mapping, @base64_mapping)
    |> Base.decode64!()
    |> :zlib.unzip()
  end

  defp translate(data, from, to) do
    translation =
      from
      |> Enum.with_index()
      |> Map.new(fn {from_char, index} ->
        {from_char, Enum.at(to, index)}
      end)

    translated_data =
      data
      |> String.to_charlist()
      |> Enum.map(&translation[&1])

    if Enum.any?(translated_data, &is_nil/1) do
      raise("Invalid format")
    else
      List.to_string(translated_data)
    end
  end
end
