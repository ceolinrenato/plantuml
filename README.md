# Plantuml

The goal of this project is implement [PlantUML](https://plantuml.com/) tooling for Elixir.

Right now it has:

- Encoding/Decoding of diagrams [https://plantuml.com/text-encoding](https://plantuml.com/text-encoding)
- Mix task to generate links with embedded diagrams pointing to a PlantUML web server (defaults to `https://plantuml.com/plantuml`)

## Installation

The package can be installed by adding `plantuml` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:plantuml, "~> 0.1", only: :dev, runtime: false}
  ]
end
```

## Documentation

The docs can be found at <https://hexdocs.pm/plantuml>.

## Auto update markdown files

Running `mix plantuml.generate_markdown_links` on the project will search for all markdown files and look for markdown comments
with links referencing to a PlantUML file in the project.

This feature was inspired by [https://github.com/danielyaa5/puml-for-markdown](https://github.com/danielyaa5/puml-for-markdown), a CLI tool built with JavaScript.

The diagrams are rendered by passing an encoded diagram to a PlantUML Web Service.

### Example

You can add an embedded diagram by adding a comment to your markdown file like this:

```
<!--![Diagram Image Link](./priv/test_assets/example_diagram.plantuml)-->
```

Result:

![Diagram Image Link](https://plantuml.com/plantuml/png/JP4v3iCW44NxEGKNI16lKeh8MUj4oWKmfa1om86XyEs36JiP2dZwJupueWieFSRt25CwZJAJj2WUZ6KGT-T0AdHUq3en9hs7taKxI3ylsPan-GAKi-ZTcEzS69ClGLiqEDFC6sFo5GmIPI-3Nh8hO_9rcZ-EMg5nDgJvVoRVm2VggDStFncJRo5jOdVCNSH1l9p8XLbSKBprPAOaipPaeY91rLXUKxvLOgRPHlqACDbcbuj0f-sm_DeN)

You can also render a link to a diagram, by doing the same thing but without prepending the `!`

```
<!--[Link to Diagram](./priv/test_assets/example_diagram.plantuml)-->
```

Result:

[Link to Diagram](https://plantuml.com/plantuml/png/JP4v3iCW44NxEGKNI16lKeh8MUj4oWKmfa1om86XyEs36JiP2dZwJupueWieFSRt25CwZJAJj2WUZ6KGT-T0AdHUq3en9hs7taKxI3ylsPan-GAKi-ZTcEzS69ClGLiqEDFC6sFo5GmIPI-3Nh8hO_9rcZ-EMg5nDgJvVoRVm2VggDStFncJRo5jOdVCNSH1l9p8XLbSKBprPAOaipPaeY91rLXUKxvLOgRPHlqACDbcbuj0f-sm_DeN)

## Contributing

See our [contribution guidelines](https://github.com/ceolinrenato/plantuml/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/ceolinrenato/plantuml/blob/main/CODE_OF_CONDUCT.md)
