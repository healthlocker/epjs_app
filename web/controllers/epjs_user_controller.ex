defmodule EpjsApp.EpjsUserController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{CarerConnection}

  def find_epjs_user(conn, %{"changeset" => changeset}) do
    epjs_user =
      changeset
      |> Poison.decode
      |> CarerConnection.find_epjs_user(decoded_changeset)
    json conn, epjs_user
  end
end
