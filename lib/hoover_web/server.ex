defmodule HooverWeb.Server do
  @moduledoc """
  Web server entrypoint.
  """

  def child_spec(opts) do
    server_opts = [
      options: opts,
      scheme: :http,
      plug: HooverWeb.Router
    ]

    Plug.Cowboy.child_spec(server_opts)
  end
end
