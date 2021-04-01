defmodule StoneChallengeHandler do
  @moduledoc """
  Module to handle the calculation and distribution of the total of a products list
  to each email from the emails collection
  """

  @spec handle(String.t(), String.t()) :: Map.t()
  def handle(products, emails) do
    products = products_format(products)
    emails = emails_format(emails)

    total = products_total(products)

    emails
    |> Enum.with_index()
    |> split_emails(total, Enum.count(emails))
    |> Map.new()
  end

  defp split_emails(emails_with_index, total, total_of_emails) do
    total_per_email = div(total, total_of_emails)
    remainder = rem(total, total_of_emails)

    Enum.map(emails_with_index, fn {email, index} ->
      total = if index < remainder, do: total_per_email + 1, else: total_per_email

      {email, total}
    end)
  end

  defp products_total(products) do
    products
    |> Enum.reduce(0, fn [_name, amount, quantity], acc ->
      String.to_integer(amount) * String.to_integer(quantity) + acc
    end)
  end

  defp products_format(products) do
    products
    |> String.split("_")
    |> Enum.chunk_every(3)
  end

  defp emails_format(emails) do
    emails
    |> String.split("_")
  end
end
