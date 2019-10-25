defmodule HooverWeb.Router do
  use HooverWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HooverWeb do
    pipe_through :browser

    resources "/", ProductController, only: [:index]
    resources "/import", ImportController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", HooverWeb do
  #   pipe_through :api
  # end
end
