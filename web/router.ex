defmodule EpjsApp.Router do
  use EpjsApp.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EpjsApp do
    pipe_through :api

    get "/care-team/for", CareTeamController, :for
  end
end
