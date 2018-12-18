defmodule TravisRelease.Endpoint do
  import Plug.Conn

  def init(_), do: []

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello world!")
  end
end
