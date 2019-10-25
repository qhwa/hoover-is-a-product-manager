defmodule HooverWeb.ProductController do
  use HooverWeb, :controller

  alias Hoover.Products

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, "index.html", products: products)
  end
end
