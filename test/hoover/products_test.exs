defmodule Hoover.ProductsTest do
  use Hoover.DataCase

  alias Hoover.Products

  describe "products" do
    alias Hoover.Products.Product

    @valid_attrs %{
      branch_id: "some branch_id",
      part_price: "120.5",
      parter_number: "some parter_number",
      short_desc: "some short_desc"
    }
    @update_attrs %{
      branch_id: "some updated branch_id",
      part_price: "456.7",
      parter_number: "some updated parter_number",
      short_desc: "some updated short_desc"
    }
    @invalid_attrs %{branch_id: nil, part_price: nil, parter_number: nil, short_desc: nil}

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

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Products.create_product(@valid_attrs)
      assert product.branch_id == "some branch_id"
      assert product.part_price == Decimal.new("120.5")
      assert product.parter_number == "some parter_number"
      assert product.short_desc == "some short_desc"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Products.update_product(product, @update_attrs)
      assert product.branch_id == "some updated branch_id"
      assert product.part_price == Decimal.new("456.7")
      assert product.parter_number == "some updated parter_number"
      assert product.short_desc == "some updated short_desc"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end

  describe "import products via CSV" do
    test "it works with empty CSV" do
      assert {:ok, 0} == Products.import_from_csv({:file, "test/fixtures/empty.csv"})
    end

    test "it works with example CSV" do
      assert {:ok, 9} == Products.import_from_csv({:file, "test/fixtures/data.csv"})
    end
  end
end
