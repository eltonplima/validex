defmodule Validex.Banking.BBAN do
  defstruct [:bank_identifier, :local_account_number]

  @type t :: %__MODULE__{}

  @doc """
  iex> Validex.Banking.BBAN.new("000788565563853695532")
  %Validex.Banking.BBAN{bank_identifier: "0007", local_account_number: "88565563853695532"}

  iex> Validex.Banking.BBAN.new("000788565563853695532")
  %Validex.Banking.BBAN{bank_identifier: "0007", local_account_number: "88565563853695532"}
  """
  def new(bban) when is_binary(bban) do
    regex = ~r/^(?P<bank_identifier>\d{4})(?P<local_account_number>\d{17})/

    params =
      Regex.named_captures(regex, bban)
      |> Map.new(fn {k, v} -> {String.to_existing_atom(k), v} end)

    Map.merge(new(), params)
  end

  def new() do
    %__MODULE__{bank_identifier: nil, local_account_number: nil}
  end
end
