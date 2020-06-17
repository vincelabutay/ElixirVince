defmodule SchedagentTest do
  use ExUnit.Case
  doctest Schedagent

  test "greets the world" do
    assert Schedagent.hello() == :world
  end
end
