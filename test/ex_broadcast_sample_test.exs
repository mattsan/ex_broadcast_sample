defmodule ExBroadcastSampleTest do
  use ExUnit.Case
  doctest ExBroadcastSample

  test "greets the world" do
    assert ExBroadcastSample.hello() == :world
  end
end
