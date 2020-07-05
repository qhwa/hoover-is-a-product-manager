defmodule Hoover.StoreState do
  use Agent

  def start_link(_arg),
    do: Agent.start_link(fn -> Store.new([]) end, name: __MODULE__)

  @doc """
  Add a list of products into the store.
  """
  @spec add(list(Product.t())) :: :ok
  def add(products),
    do: Agent.update(__MODULE__, &Store.add_products(&1, products))

  @doc """
  Replace current store with a list of products.
  """
  @spec set(list(Product.t())) :: :ok
  def set(products),
    do: Agent.update(__MODULE__, fn _ -> Store.new(products) end)

  @doc """
  Get current products
  """
  @spec products() :: list(Product.t())
  def products(),
    do: Agent.get(__MODULE__, & &1) |> Map.values()

  @doc """
  Import products from an external CSV file stream.
  """
  @spec import_from_csv(Enumerable.t()) :: :ok
  def import_from_csv(file_stream) do
    with csv_stream <- CSV.decode(file_stream, separator: ?|, headers: true) do
      csv_stream
      |> Stream.map(&parse_line/1)
      |> Stream.take_while(&match?(%Product{}, &1))
      |> add()
    end
  end

  defp parse_line(
         {:ok,
          %{
            "PART_NUMBER" => part_number,
            "BRANCH_ID" => branch_id,
            "PART_PRICE" => part_price,
            "SHORT_DESC" => short_desc
          }}
       ),
       do: %Product{
         part_number: part_number,
         branch_id: branch_id,
         part_price: part_price,
         short_desc: short_desc
       }

  defp parse_line({:error, reason}), do: {:error, reason}
end
