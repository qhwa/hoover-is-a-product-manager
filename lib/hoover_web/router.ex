defmodule HooverWeb.Router do
  use Plug.Router

  alias Hoover.StoreState, as: Store

  @template "lib/hoover_web/template/index.html.eex"

  require EEx
  EEx.function_from_file(:defp, :render_index, @template, [:assigns])
  @external_resource @template

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart],
    pass: ["*/*"]
  )

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> send_resp(:ok, render_index(products: Store.products()))
  end

  post "/" do
    with %{"sheet" => %Plug.Upload{path: path}} <- conn.params,
         %File.Stream{} = stream <- File.stream!(path),
         :ok <- import_products(stream, conn.params) do
      conn
      |> put_resp_header("location", "/")
      |> send_resp(302, "successfully imported!")
    end
  end

  match _ do
    send_resp(conn, :not_found, "Page not found")
  end

  defp import_products(stream, %{"delete_others" => "on"}),
    do: Store.replace_with_csv(stream)

  defp import_products(stream, _),
    do: Store.import_from_csv(stream)
end
