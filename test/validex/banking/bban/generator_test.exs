defmodule Validex.Banking.BBAN.GeneratorTest do
  use ExUnit.Case
  doctest Validex.Banking.BBAN.Generator
  alias Validex.Banking.BBAN

  test "generate" do
    assert {:ok, bban} = Validex.Banking.BBAN.Generator.generate()
    assert %BBAN{} = bban
    assert String.length(bban.bank_identifier) == 4
    assert String.length(bban.local_account_number) == 17
  end
end
