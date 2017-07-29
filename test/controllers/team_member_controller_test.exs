defmodule EpjsApp.TeamMemberControllerTest do
  use EpjsApp.ConnCase
  alias EpjsApp.{EPJSTeamMember, Repo}

  describe "team member controller returns json response with valid user data" do
    setup %{} do
      Repo.insert!(%EPJSTeamMember{
        Patient_ID: 123,
        Staff_ID: 321,
        Staff_Name: "rob stallion",
        Job_Title: "clinician",
        Team_Member_Role_Desc: "care team lead",
        Email: "rob@email.com",
        User_Guid: "randomstringtotestwith"
      })

      :ok
    end

    test "GET /epjsteammember/clinician-connection/find-clinician?user_data=", %{conn: conn} do
      user_data = "UserName=robert_macmurray@nhs.co.uk&UserId=randomstringtotestwith&tokenexpiry=3000-06-23T11:15:53"
      conn = get conn, "http://localhost:4001/epjsteammember/clinician-connection/find-clinician?user_data=" <> user_data
      clinician = conn.resp_body
      |> Poison.decode!
      |> Map.get("clinician")
      |> Enum.at(0)
      assert clinician["Staff_ID"] == 321
    end
  end

  describe "team member controller returns empty clinician list with invalid user_data" do
    test "GET /epjsteammember/clinician-connection/find-clinician?user_data=", %{conn: conn} do
      user_data = "UserName=robert_macmurray@nhs.co.uk&UserId=randomstringtotestwith&tokenexpiry=3000-06-23T11:15:53"
      conn = get conn, "http://localhost:4001/epjsteammember/clinician-connection/find-clinician?user_data=" <> user_data
      assert conn.resp_body == "{\"decrypted_user_guid\":\"randomstringtotestwith\",\"decrypted_time_str\":\"3000-06-23T11:15:53\",\"clinician\":[]}"
      assert conn.resp_body
      |> Poison.decode!
      |> Map.get("clinician") == []
    end
  end
end
