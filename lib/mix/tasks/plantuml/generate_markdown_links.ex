defmodule Mix.Tasks.Plantuml.GenerateMarkdownLinks do
  @shortdoc "Updates all markdown files to include links with embedded PlantUML diagrams."

  @moduledoc """
  Searches the project for markdown files and updates them to include links with
  embedded PlantUML diagrams whenever there's a markdown comment refering a plantuml
  diagram also present on the project.

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

  use Mix.Task

  @excluded [~r"/_build/", ~r"/deps/", ~r"/node_modules/", ~r"/priv/", ~r"/plantuml/README.md"]

  def run(_) do
    markdown_files()
    |> Enum.map(fn file_path ->
      Task.async(fn ->
        new_content = Plantuml.Markdown.generate_diagram_links(file_path)

        File.write!(file_path, new_content)
      end)
    end)
    |> Task.await_many()
  end

  defp markdown_files do
    File.cwd!()
    |> Path.join("/**/*.md")
    |> Path.wildcard()
    |> Enum.reject(fn file ->
      Enum.any?(@excluded, &Regex.match?(&1, file))
    end)
  end
end
