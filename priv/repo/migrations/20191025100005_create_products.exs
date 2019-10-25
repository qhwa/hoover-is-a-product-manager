defmodule Hoover.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :part_number, :string, null: false
      add :branch_id, :string, null: false
      add :part_price, :decimal, null: false
      add :short_desc, :string

      timestamps()
    end

    create unique_index(:products, :part_number)
  end
end
