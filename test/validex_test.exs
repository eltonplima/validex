defmodule ValidexTest do
  use ExUnit.Case
  doctest Validex

  test "greets the world" do
    assert Validex.hello() == :world
  end
end
