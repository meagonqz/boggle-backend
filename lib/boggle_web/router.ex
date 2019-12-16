defmodule BoggleWeb.Router do
  use BoggleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_cookies
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Boggle.Guardian.AuthPipeline
    plug Boggle.GraphQL.Context
  end

  scope "/", BoggleWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: BoggleWeb.Schema

    forward "/", Absinthe.Plug, schema: BoggleWeb.Schema
  end

  scope "/auth", BoggleWeb do
    pipe_through :browser
    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :new)
  end
end
