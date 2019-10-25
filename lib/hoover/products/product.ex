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
      |> Stream.map(&insert/1)
      |> Enum.to_list()
      |> Enum.reject(&is_nil/1)

    # TODO: what if some inserting failed? should in a transaction
    {:ok, success_count(products)}
  end

  defp insert([part_number, branch_id, part_price, short_desc]) do
    changeset(%__MODULE__{}, %{
      part_number: part_number,
      branch_id: branch_id,
      part_price: String.to_float(part_price),
      short_desc: short_desc
    })
    |> Repo.insert(
      on_conflict: :replace_all,
      conflict_target: :part_number
    )
  end

  defp insert(_) do
    nil
  end

  defp success_count(products) do
    products
    |> Enum.map(fn
      {:ok, %{part_number: pn}} ->
        pn

      _ ->
        nil
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.uniq()
    |> Enum.count()
  end
end
