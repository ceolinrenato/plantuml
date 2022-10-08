defmodule PlantumlTest do
  use ExUnit.Case
  doctest Plantuml

  test "greets the world" do
    assert Plantuml.hello() == :world
  end
end
