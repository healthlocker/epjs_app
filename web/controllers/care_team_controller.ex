defmodule EpjsApp.CareTeamController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{CareTeam}

  @moduledoc """
  For a given service user query EPJS for all the associated clinicians,
  these will form the user's care team.
  """
  def for(conn, %{"service_user" => service_user}) do
  # pattern matches against params for the service user,
  # grabs the data and then uses it to make a call to EJPS DB
    care_team =
      service_user
      |> Poison.decode!
      |> CareTeam.for
    json conn, care_team
  end
end
