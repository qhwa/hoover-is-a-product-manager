defmodule HooverTest do
  use ExUnit.Case
  doctest Hoover

  test "greets the world" do
    assert Hoover.hello() == :world
  end
end
