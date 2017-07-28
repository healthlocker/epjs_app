defmodule EpjsApp.CareTeamTest do
  use EpjsApp.ModelCase, async: true
  alias EpjsApp.{CareTeam, EPJSTeamMember, Repo}

  setup %{} do
    Repo.insert!(%EPJSTeamMember{
      Patient_ID: 123,
      Staff_ID: 321,
      Staff_Name: "rob stallion",
      Job_Title: "clinician",
      Team_Member_Role_Desc: "care team lead",
      Email: "rob@email.com",
      User_Guid: "1234567890"
    })

    :ok
  end

  describe "CareTeam for function" do
    test "gets care team for a user from the database" do
      clinician_email =
        CareTeam.for(%{slam_id: 123})
        |> Enum.at(0)
        |> Map.get(:Email)
      assert clinician_email == "rob@email.com"
    end
  end
end
