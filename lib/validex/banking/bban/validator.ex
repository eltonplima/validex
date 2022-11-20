defmodule Validex.Banking.BBAN.Validator do
  alias Validex.Banking.BBAN

  @doc """
  Check if BBAN is valid

  iex> alias Validex.Banking.BBAN.Validator
  iex> Validator.valid?("853114809472329760329")
  true

  iex> alias Validex.Banking.BBAN.Validator
  iex> Validator.valid?(853114809472329760329)
  true

  iex> alias Validex.Banking.BBAN.Validator
  iex> Validator.valid?("853114809472329760320")
  false

  iex> alias Validex.Banking.BBAN.Validator
  iex> Validator.valid?(853114809472329760320)
  false

  iex> alias Validex.Banking.BBAN.Validator
  iex> alias Validex.Banking.BBAN
  iex> Validator.valid?(%BBAN{bank_identifier: "8531", local_account_number: "14809472329760320", normalized: "853114809472329760320"})
  false

  iex> alias Validex.Banking.BBAN.Validator
  iex> alias Validex.Banking.BBAN
  iex> Validator.valid?(%BBAN{bank_identifier: "8531", local_account_number: "14809472329760329", normalized: "853114809472329760329"})
  true
  """

  # TODO: Validate length
  def valid?(%BBAN{} = bban) do
    valid?(bban.normalized)
  end

  def valid?(bban) when is_binary(bban) do
    {bban, _} = Integer.parse(bban)
    valid?(bban)
  end

  def valid?(bban) when is_number(bban) do
    bban
    |> rem(97)
    |> case do
      1 -> true
      _ -> false
    end
  end
end
