defmodule RithTest do
  use ExUnit.Case
  doctest Rith

  test "greets the world" do
    assert Rith.hello() == :world
  end
end
