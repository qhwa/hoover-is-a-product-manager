defmodule HooverWeb.ImportController do
  use HooverWeb, :controller

  alias Hoover.Products

  def create(conn, %{"file" => %Plug.Upload{path: path}}) do
    case Products.import_from_csv({:file, path}) do
      {:ok, count} ->
        conn
        |> put_flash(:info, "#{count} products imported successfully.")
        |> redirect(to: Routes.product_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
