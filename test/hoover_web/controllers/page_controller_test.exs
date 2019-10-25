defmodule HooverWeb.PageControllerTest do
  use HooverWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Products"
  end
end
