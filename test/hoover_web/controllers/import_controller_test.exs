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
    end
  end
end
