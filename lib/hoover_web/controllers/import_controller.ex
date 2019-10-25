defmodule HooverWeb.ImportController do
  use HooverWeb, :controller

  alias Hoover.Products

  def create(conn, %{"file" => %Plug.Upload{path: path}}) do
    case Products.import_from_csv({:file, path}) do
      {:ok, 0} ->
        conn
        |> put_flash(:error, "No products found.")
        |> redirect(to: Routes.product_path(conn, :index))

      {:ok, count} ->
        conn
        |> put_flash(:info, "#{count} products were successfully imported.")
        |> redirect(to: Routes.product_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create(conn, _) do
    conn
    |> put_flash(:error, "No products found.")
    |> redirect(to: Routes.product_path(conn, :index))
  end
end
