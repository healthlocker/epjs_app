defmodule EpjsApp.PageControllerTest do
  use EpjsApp.ConnCase
  alias EpjsApp.{EPJSTeamMember, Repo}

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

  describe "care team controller works as expected" do
    test "GET /care-team/for?service_user", %{conn: conn} do

      stringified_user = %{slam_id: 123} |> Poison.encode!
      conn = get conn, "http://localhost:4001/care-team/for?service_user=" <> stringified_user
      assert json_response(conn, 200)
    end
  end
end
