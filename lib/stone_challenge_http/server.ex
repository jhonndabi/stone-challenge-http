defmodule StoneChallengeHttp.Server do
  @moduledoc """
  Stone Challenge API
  """

  use Plug.Router

  plug :match
  plug :dispatch

  get "/:products/:emails" do
    body = StoneChallengeHandler.handle(products, emails)

    send_resp(conn, 200, body)
  end

  get "/challenge_by_query" do
    conn = fetch_query_params(conn)
    %{"products" => products, "emails" => emails} = conn.query_params

    body = StoneChallengeHandler.handle(products, emails)

    send_resp(conn, 200, body)
  end

  match _ do
    send_resp(conn, 404, "Page not found!")
  end
end
