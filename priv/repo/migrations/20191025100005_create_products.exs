defmodule Hoover.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :parter_number, :string
      add :branch_id, :string
      add :part_price, :decimal
      add :short_desc, :string

      timestamps()
    end
  end
end
