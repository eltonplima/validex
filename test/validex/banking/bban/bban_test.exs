defmodule Validex.Banking.BBANTest do
  use ExUnit.Case
  doctest Validex.Banking.BBAN

  alias Validex.Banking.BBAN

  describe "new/1" do
    test "return error when receive invalid param" do
      assert {:error, :invalid} = BBAN.new(1)
    end
  end
end
