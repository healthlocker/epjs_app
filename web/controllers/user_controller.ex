defmodule EpjsApp.UserController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{CarerConnection}
  import EpjsApp.Encoder, only: [sanitize_map: 1]

  def find_user(conn, %{"changeset" => changeset}) do
    epjs_user =
      changeset
      |> Poison.decode!
      |> CarerConnection.find_user
      |> sanitize_map

    json conn, epjs_user
  end
end
