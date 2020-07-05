defmodule HooverWeb.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "<h1>Hello world</h1>")
  end
end
