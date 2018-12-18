defmodule TravisReleaseTest do
  use ExUnit.Case
  doctest TravisRelease

  test "greets the world" do
    assert TravisRelease.hello() == :world
  end
end
