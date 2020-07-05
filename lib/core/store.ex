defmodule Store do
  @moduledoc """
  Storage of products.
  """

  @type t :: %{binary() => Product.t()}

  @doc """
  Create a new stores for products.
  """
  @spec new(list(Product.t())) :: t()
  def new(products), do: Map.new(products, fn %{part_number: id} = product -> {id, product} end)

  @doc """
  Add a list of products into an existing store.

  If a product with the same id already exists within the store,
  the existing one will get replaced.
  """
  @spec add_products(t(), list(Product.t())) :: t()
  def add_products(store, products),
    do: for(%{part_number: id} = prd <- products, into: store, do: {id, prd})
end
