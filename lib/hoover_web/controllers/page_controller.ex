defmodule HooverWeb.PageController do
  use HooverWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
