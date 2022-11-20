defmodule Validex.Banking.BBAN do
  @enforce_keys [:bank_identifier, :local_account_number, :normalized]
  defstruct [:bank_identifier, :local_account_number, :normalized]

  @type t :: %__MODULE__{}

  @doc """
  iex> Validex.Banking.BBAN.new("000788565563853695532")
  %Validex.Banking.BBAN{bank_identifier: "0007", local_account_number: "88565563853695532", normalized: "000788565563853695532"}

  iex> Validex.Banking.BBAN.new("000788565563853695532")
  %Validex.Banking.BBAN{bank_identifier: "0007", local_account_number: "88565563853695532", normalized: "000788565563853695532"}
  """
  def new(bban) when is_binary(bban) do
    regex = ~r/^(?P<bank_identifier>\d{4})(?P<local_account_number>\d{17})/

    with :ok <- sanity_check(bban),
         named_captures <- Regex.named_captures(regex, bban),
         params <- Map.new(named_captures, fn {k, v} -> {String.to_existing_atom(k), v} end),
         params <-
           Map.merge(params, %{
             normalized: "#{params.bank_identifier}#{params.local_account_number}"
           }) do
      Map.merge(new(), params)
    end
  end

  def new(_invalid), do: {:error, :invalid}

  def new() do
    %__MODULE__{bank_identifier: nil, local_account_number: nil, normalized: nil}
  end

  defp sanity_check(bban) do
    bban
    |> String.length()
    |> case do
      21 -> :ok
      _ -> {:error, :invalid}
    end
  end
end
