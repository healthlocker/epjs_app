defmodule EpjsApp.CareTeam do
  alias EpjsApp.{Repo, EPJSTeamMember}
  import Ecto.Query

  @moduledoc """
  For a given service user query EPJS for all the associated clinicians,
  these will form the user's care team.
  """
  def for(%{"slam_id" => slam_id}) do
    query = from e in EPJSTeamMember,
      where: e."Patient_ID" == ^slam_id

    Repo.all(query)
  end
end
