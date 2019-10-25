defmodule HooverWeb.ImportControllerTest do
  use HooverWeb.ConnCase

  describe "create an importing" do
    test "redirects to show when data is valid", %{conn: conn} do
      upload = %Plug.Upload{
        path: "test/fixtures/data.csv",
        filename: "my-fancy-data-sheet.csv"
      }

      conn = post(conn, Routes.import_path(conn, :create), file: upload)

      assert redirected_to(conn) == Routes.product_path(conn, :index)
      assert %{"info" => "8 products were successfully imported."} == get_flash(conn)
    end

    test "redirects to show when data is empty", %{conn: conn} do
      upload = %Plug.Upload{
        path: "test/fixtures/empty.csv",
        filename: "my-fancy-data-sheet.csv"
      }

      conn = post(conn, Routes.import_path(conn, :create), file: upload)

      assert redirected_to(conn) == Routes.product_path(conn, :index)
      assert %{"error" => "No products found."} == get_flash(conn)
    end
  end
end
