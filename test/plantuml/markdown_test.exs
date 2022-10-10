defmodule Plantuml.MarkdownTest do
  use ExUnit.Case, async: true

  describe "generate_diagram_links/1" do
    test "generate plantuml encoded diagrams links based on markdown link comments referencing plantuml diagrams" do
      test_file_path =
        :plantuml
        |> Application.app_dir()
        |> Path.join("/priv/test_assets/example_md.md")

      assert """
             # Example

             [Some Link](https://plantuml.com/plantuml/png/JP4v3iCW44NxEGKNI16lKeh8MUj4oWKmfa1om86XyEs36JiP2dZwJupueWieFSRt25CwZJAJj2WUZ6KGT-T0AdHUq3en9hs7taKxI3ylsPan-GAKi-ZTcEzS69ClGLiqEDFC6sFo5GmIPI-3Nh8hO_9rcZ-EMg5nDgJvVoRVm2VggDStFncJRo5jOdVCNSH1l9p8XLbSKBprPAOaipPaeY91rLXUKxvLOgRPHlqACDbcbuj0f-sm_DeN)<!--[Some Link](./example_diagram.plantuml)-->

             ![Some Rendered Diagram](https://plantuml.com/plantuml/png/JP4v3iCW44NxEGKNI16lKeh8MUj4oWKmfa1om86XyEs36JiP2dZwJupueWieFSRt25CwZJAJj2WUZ6KGT-T0AdHUq3en9hs7taKxI3ylsPan-GAKi-ZTcEzS69ClGLiqEDFC6sFo5GmIPI-3Nh8hO_9rcZ-EMg5nDgJvVoRVm2VggDStFncJRo5jOdVCNSH1l9p8XLbSKBprPAOaipPaeY91rLXUKxvLOgRPHlqACDbcbuj0f-sm_DeN)<!--![Some Rendered Diagram](./example_diagram.plantuml)-->
             """ == Plantuml.Markdown.generate_diagram_links(test_file_path)
    end
  end
end
