defmodule BoggleWeb.Router do
  use BoggleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  forward "/api", Absinthe.Plug, schema: BoggleWeb.Schema

  scope "/", BoggleWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BoggleWeb do
  #   pipe_through :api
  # end
end
