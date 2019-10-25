defmodule Hoover.Repo do
  use Ecto.Repo,
    otp_app: :hoover,
    adapter: Ecto.Adapters.Postgres
end
