defmodule StoneChallengeHttp.Server do
  @moduledoc """
  Stone Challenge API
  """

  use Plug.Router

  plug :match
  plug :dispatch

  get "/:products/:emails" do
    StoneChallengeHandler.handle(products, emails)
    |> send_json(conn, 200)
  end

  get "/challenge_by_query" do
    conn = fetch_query_params(conn)
    %{"products" => products, "emails" => emails} = conn.query_params

    StoneChallengeHandler.handle(products, emails)
    |> send_json(conn, 200)
  end

  get "/challenge_by_headers" do
    [products | _] = get_req_header(conn, "products")
    [emails | _] = get_req_header(conn, "emails")

    StoneChallengeHandler.handle(products, emails)
    |> send_json(conn, 200)
  end

  post "/post_hello" do
    send_resp(conn, 200, "Hello from post")
  end

  match _ do
    send_resp(conn, 404, "Page not found!")
  end

  defp send_json(map, conn, status) do
    conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(status, Jason.encode!(map))
  end
end
