defmodule EpjsApp.Router do
  use EpjsApp.Web, :router

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

  scope "/api", EpjsApp do
    pipe_through :api

    get "/", PageController, :index
  end
end
