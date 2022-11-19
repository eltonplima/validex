defmodule Validex.IBAN do
  @enforce_keys [:value, :bank, :branch, :account, :check_digits]
  defstruct [:value, :country, :country_check_digits, :bank, :branch, :account, :check_digits]

  @doc """
  iex> Validex.IBAN.new("PT50000788565563853695532")
  %Validex.IBAN{country: "PT", bank: "0007", branch: "8856", account: "55638536955", check_digits: "32", value: "PT50000788565563853695532", country_check_digits: "50"}

  iex> Validex.IBAN.new("000788565563853695532")
  %Validex.IBAN{country: "", bank: "0007", branch: "8856", account: "55638536955", check_digits: "32", value: "000788565563853695532", country_check_digits: ""}
  """
  def new(params) when is_map(params) do
    Map.merge(new(), params)
  end

  def new(iban) when is_binary(iban) do
    regex =
      ~r/^((?P<country>\w{2})(?P<country_check_digits>\d{2}))?(?P<bank>\d{4})(?P<branch>\d{4})(?P<account>\d{11})(?P<check_digits>\d{2})/

    params =
      Regex.named_captures(regex, iban)
      |> Map.new(fn {k, v} -> {String.to_existing_atom(k), v} end)
      |> Map.merge(%{value: iban})

    Map.merge(new(), params)
  end

  def new() do
    %__MODULE__{value: nil, bank: nil, branch: nil, account: nil, check_digits: nil}
  end
end
