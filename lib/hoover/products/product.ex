defmodule Hoover.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hoover.Repo

  NimbleCSV.define(Parser, separator: "|")

  schema "products" do
    field :branch_id, :string
    field :part_price, :decimal
    field :part_number, :string
    field :short_desc, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:part_number, :branch_id, :part_price, :short_desc])
    |> validate_required([:part_number, :branch_id, :part_price, :short_desc])
  end

  @doc """
  import products from a local CSV file.
  """
  def import_from_csv({:file, path}) do
    products =
      path
      |> File.stream!()
      |> Parser.parse_stream()
      |> Stream.map(fn
        [part_number, branch_id, part_price, short_desc] ->
          changeset(%__MODULE__{}, %{
            part_number: part_number,
            branch_id: branch_id,
            part_price: String.to_float(part_price),
            short_desc: short_desc
          })
          |> Repo.insert(on_conflict: :replace_all, conflict_target: :part_number)

        _ ->
          nil
      end)
      |> Enum.to_list()
      |> Enum.reject(&is_nil/1)

    # TODO: filter only successful insert
    # TODO: what if some inserting failed? should in a transaction
    {:ok, length(products)}
  end

  def import_from_csv(content) when is_binary(content) do
    {:ok, 0}
  end
end
