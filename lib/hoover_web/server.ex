defmodule HooverWeb.Server do
  def child_spec(opts) do
    server_opts = [
      options: opts,
      scheme: :http,
      plug: HooverWeb.Router
    ]

    Plug.Cowboy.child_spec(server_opts)
  end
end
