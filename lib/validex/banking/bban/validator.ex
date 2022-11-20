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
  """

  # TODO: Validate length
  # TODO: Accept BBAN structure
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
