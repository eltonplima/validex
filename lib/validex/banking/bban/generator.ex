defmodule Validex.Banking.BBAN.Generator do
  @moduledoc """
  Module responsible for BBAN generation

  https://community.appway.com/screen/kb/article/generating-and-validating-an-iban-1683400256881
  https://pt.wikipedia.org/wiki/N%C3%BAmero_de_Identifica%C3%A7%C3%A3o_Banc%C3%A1ria
  https://pt.wikipedia.org/wiki/International_Bank_Account_Number
  https://www.bportugal.pt/sites/default/files/anexos/documentos-relacionados/international_bank_account_number_en.pdf

  Moving parts:
  - generator - responsible for generate BBAN
  - validator - responsible for validate BBAN
  - formatter - responsible for formatting BBAN

  Use Elixir protocol to dispatch
    - Validex.generate_iban(country: "PT")
      - Validex.Banking.BBAN.Generator.Generate.new(country) |> Validex.Banking.BBAN.Generator.generate() # dispatch based on protocol
  """
  alias Validex.Banking.BBAN

  # TODO: Support bank param
  # TODO: Validate bank(per country)
  def generate() do
    #    bank = Keyword.get(opts, :bank)
    #    bban = generate(bank)
    bban = generate_random()

    check_digit =
      bban
      |> String.slice(0, 19)
      |> calculate_check_digit()
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    bban = BBAN.new("#{bban}#{check_digit}")
    {:ok, bban}
  end

  # TODO: Move to support module
  def generate_random_int(number_of_digits) do
    String.duplicate("9", number_of_digits) |> String.to_integer() |> :rand.uniform()
  end

  defp generate_random() do
    generate_random_int(19) |> Integer.to_string()
  end

  defp calculate_check_digit(bban) when is_binary(bban) do
    result =
      bban
      |> String.split("", trim: true)
      |> Enum.reduce(0, fn digit, acc ->
        digit = String.to_integer(digit)
        ((acc + digit) * 10) |> rem(97)
      end)

    98 - ((result * 10) |> rem(97))
  end
end
