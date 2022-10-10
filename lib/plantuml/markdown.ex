defmodule Plantuml.Markdown do
  @moduledoc """
  Some functions to work with markdown files referencing plantuml diagrams
  """

  @plantuml_diagram_link_regexp ~r"(?:!*\[.*\]\([^)]+\))?<!\-\-(!?\[[^\]]+\])\(([^)]+\.(?:puml|plantuml))\)\-\->"

  @doc """
  Reads a markdown file at a given location and generate links with encoded PlantUML diagrams whenever
  there's a markdown comment with a link referencing a plantuml diagram

  ## Example
  A markdown file looking like this:
  ```
  # Example

  <!--[Some Link](./example_diagram.plantuml)-->

  <!--![Some Rendered Diagram](./example_diagram.plantuml)-->
  ```

  Would yield an output like this:
  ```
  # Example

  [Some Link](https://plantuml.com/plantuml/png/JP4v3iCW44NxEGKNI16lKeh8MUj4oWKmfa1om86XyEs36JiP2dZwJupueWieFSRt25CwZJAJj2WUZ6KGT-T0AdHUq3en9hs7taKxI3ylsPan-GAKi-ZTcEzS69ClGLiqEDFC6sFo5GmIPI-3Nh8hO_9rcZ-EMg5nDgJvVoRVm2VggDStFncJRo5jOdVCNSH1l9p8XLbSKBprPAOaipPaeY91rLXUKxvLOgRPHlqACDbcbuj0f-sm_DeN)<!--[Some Link](./example_diagram.plantuml)-->

  ![Some Rendered Diagram](https://plantuml.com/plantuml/png/JP4v3iCW44NxEGKNI16lKeh8MUj4oWKmfa1om86XyEs36JiP2dZwJupueWieFSRt25CwZJAJj2WUZ6KGT-T0AdHUq3en9hs7taKxI3ylsPan-GAKi-ZTcEzS69ClGLiqEDFC6sFo5GmIPI-3Nh8hO_9rcZ-EMg5nDgJvVoRVm2VggDStFncJRo5jOdVCNSH1l9p8XLbSKBprPAOaipPaeY91rLXUKxvLOgRPHlqACDbcbuj0f-sm_DeN)<!--![Some Rendered Diagram](./example_diagram.plantuml)-->
  ```
  """
  @spec generate_diagram_links(file_path :: Path.t()) ::
          markdown_content_with_diagram_links :: String.t()
  def generate_diagram_links(file_path) do
    content = File.read!(file_path)

    Regex.replace(
      @plantuml_diagram_link_regexp,
      content,
      fn _match, link_description, diagram_path ->
        file_dir = Path.dirname(file_path)

        diagram =
          diagram_path
          |> Path.expand(file_dir)
          |> File.read!()

        encoded_diagram = Plantuml.Encoding.encode(diagram)

        "#{link_description}(#{plantuml_server_url()}/png/#{encoded_diagram})<!--#{link_description}(#{diagram_path})-->"
      end
    )
  end

  defp plantuml_server_url,
    do: Application.get_env(:plantuml, :plantuml_server_url, "https://plantuml.com/plantuml")
end
