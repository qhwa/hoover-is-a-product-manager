defmodule Hoover.Application do
  @moduledoc false

  use Application

  def start(_, _) do
    children = [
      Hoover.StoreState,
      {HooverWeb.Server, port: 4000}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
