defmodule HooverWebTest do
  use ExUnit.Case
  use Plug.Test

  alias Hoover.StoreState

  @opts HooverWeb.Router.init([])

  setup do
    GenServer.whereis(StoreState)
    |> :sys.replace_state(fn _ -> Store.new([]) end)

    :ok
  end

  describe "GET /" do
    test "it works" do
      conn = conn(:get, "/") |> HooverWeb.Router.call(@opts)

      assert conn.status == 200
      assert conn.resp_body =~ "Products"
    end
  end

  describe "Dealing with upload" do
    test "it works incrementally with a CSV" do
      add_product("0")

      conn = conn(:post, "/", sheet: random_csv_file()) |> HooverWeb.Router.call(@opts)

      actual = StoreState.products()

      assert conn.status == 302
      assert conn.resp_headers |> Enum.any?(&match?({"location", "/"}, &1))
      assert 21 == length(actual)
      assert actual |> Enum.any?(&(&1.part_number == "0"))
    end

    test "it works with a replacing CSV" do
      add_product("0")

      conn =
        conn(:post, "/", sheet: random_csv_file(), delete_others: "on")
        |> HooverWeb.Router.call(@opts)

      actual = StoreState.products()

      assert conn.status == 302
      assert conn.resp_headers |> Enum.any?(&match?({"location", "/"}, &1))
      assert 20 == length(actual)
      refute actual |> Enum.any?(&(&1.part_number == "0"))
    end
  end

  describe "Error Routes" do
    test "404" do
      conn = conn(:get, "/foo") |> HooverWeb.Router.call(@opts)
      assert conn.status == 404
    end
  end

  defp random_csv_file do
    header = "PART_NUMBER|BRANCH_ID|PART_PRICE|SHORT_DESC\r\n"

    bin =
      for(i <- 1..20, do: random_product(i))
      |> CSV.encode(separator: ?|)
      |> Enum.to_list()
      |> Enum.join()

    {:ok, path} = Plug.Upload.random_file("csv")
    File.write!(path, header <> bin)

    %Plug.Upload{
      path: path,
      filename: "random_products.csv"
    }
  end

  defp add_product(id),
    do:
      StoreState.add([
        %Product{
          part_number: id,
          branch_id: random_string(),
          part_price: random_price()
        }
      ])

  defp random_product(id) do
    [
      to_string(id),
      random_string(),
      random_price(),
      random_string()
    ]
  end

  defp random_string, do: :crypto.strong_rand_bytes(64) |> Base.encode32()
  defp random_price, do: :rand.uniform(1000)
end
