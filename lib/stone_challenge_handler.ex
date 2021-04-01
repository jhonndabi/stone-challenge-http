defmodule StoneChallengeHandler do
  def handle(products, emails) do
    products = products_format(products)
    emails = emails_format(emails)

    total = products_total(products)
    total_per_email = div(total, Enum.count(emails))
    total_remainder = rem(total, Enum.count(emails))

    split_emails(emails, total_per_email)
      |> split_remainder(total_remainder)
      |> Poison.encode!
  end

  defp split_emails(emails, total_per_email) do
    Enum.reduce(emails, %{}, fn email, acc ->
      Map.put(acc, email, total_per_email)
    end)
  end

  defp split_remainder(splitted, 0), do: splitted

  defp split_remainder(splitted, remainder) do
    %{res: splitted_res} =
      Enum.reduce(splitted, %{res: %{}, rem: remainder}, fn
        {email, amount}, %{res: %{}, rem: 0} = acc ->
          %{res: Map.put(acc.res, email, amount), rem: 0}

        {email, amount}, acc ->
          %{res: Map.put(acc.res, email, amount + 1), rem: acc.rem - 1}
      end)

    splitted_res
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
