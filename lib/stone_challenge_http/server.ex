defmodule StoneChallengeHttp.Server do
  @moduledoc """
  Stone Challenge API
  """

  use Plug.Router

  plug(:match)
  plug(:dispatch)

  match _ do
    send_resp(conn, 404, "Page not found!")
  end
end