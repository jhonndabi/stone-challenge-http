defmodule StoneChallengeHttp.Server do
  @moduledoc """
  Stone Challenge API
  """

  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/:products/:emails" do
    send_resp(
      conn,
      200,
      StoneChallengeHandler.handle(products, emails)
    )
  end

  match _ do
    send_resp(conn, 404, "Page not found!")
  end
end
