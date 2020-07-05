defmodule Hoover.Application do
  use Application

  def start(_, _) do
    children = [
      Hoover.StoreState
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
