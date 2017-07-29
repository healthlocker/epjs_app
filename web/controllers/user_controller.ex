defmodule EpjsApp.UserController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{CarerConnection}

  def find_user(conn, %{"changeset" => changeset}) do
    epjs_user =
      changeset
      |> Poison.decode!
      |> CarerConnection.find_user
    json conn, epjs_user
  end
end
