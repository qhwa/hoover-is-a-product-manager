defmodule Hoover.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :branch_id, :string
    field :part_price, :decimal
    field :parter_number, :string
    field :short_desc, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:parter_number, :branch_id, :part_price, :short_desc])
    |> validate_required([:parter_number, :branch_id, :part_price, :short_desc])
  end
end
