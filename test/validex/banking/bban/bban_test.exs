defmodule Validex.Banking.BBANTest do
  use ExUnit.Case
  doctest Validex.Banking.BBAN

  alias Validex.Banking.BBAN

  describe "new/1 returns error when invalid parameter" do
    test "integer" do
      assert {:error, :invalid} = BBAN.new(1)
    end

    test "invalid length" do
      assert {:error, :invalid} = BBAN.new("1")
    end

    test "nil" do
      assert {:error, :invalid} = BBAN.new(nil)
    end
  end
end
