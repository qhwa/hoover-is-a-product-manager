defmodule Hoover.ProductsTest do
  use Hoover.DataCase

  alias Hoover.Products

  describe "products" do
    @valid_attrs %{
      branch_id: "some branch_id",
      part_price: "120.5",
      part_number: "some part_number",
      short_desc: "some short_desc"
    }

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end
  end

  describe "import products via CSV" do
    test "it works with empty CSV" do
      assert {:ok, 0} == Products.import_from_csv({:file, "test/fixtures/empty.csv"})
    end

    test "it works with example CSV" do
      assert {:ok, 8} == Products.import_from_csv({:file, "test/fixtures/data.csv"})
    end

    test "it updates existing records" do
      Products.import_from_csv({:file, "test/fixtures/data.csv"})
      Products.import_from_csv({:file, "test/fixtures/data.csv"})

      assert Hoover.Repo.aggregate(from(p in "products"), :count, :id) == 8
    end
  end
end
