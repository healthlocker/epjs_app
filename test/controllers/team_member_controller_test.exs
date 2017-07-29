defmodule EpjsApp.TeamMemberControllerTest do
  use EpjsApp.ConnCase
  alias EpjsApp.{EPJSUser, EPJSTeamMember, Repo}

  describe "routes with no clinician return empty lists" do
    test "GET /epjsteammember/clinician-connection/find-clinician?user_data=", %{conn: conn} do
      user_data = "UserName=robert_macmurray@nhs.co.uk&UserId=badS tring&tokenexpiry=3000-06-23T11:15:53"
      conn = get conn, "/epjsteammember/clinician-connection/find-clinician?user_data=" <> user_data
      assert conn.resp_body == "{\"decrypted_user_guid\":\"randomstringtotestwith\",\"decrypted_time_str\":\"3000-06-23T11:15:53\",\"clinician\":[]}"
      assert conn.resp_body
      |> Poison.decode!
      |> Map.get("clinician") == []
    end

    test "GET /epjsteammember/clinician-connection/get-patients?clinician= with clinician not in db returns no data", %{conn: conn} do
      clinician = %{
        id: 321,
        first_name: "rob",
        last_name: "stallion",
        email: "rob@email.com",
        security_question: "Question?",
        security_answer: "Answer",
        role: "clinician",
        user_guid: "randomstringtotestwith"
      } |> Poison.encode!

      conn = get conn, "/epjsteammember/clinician-connection/get-patients?clinician=" <> clinician
      assert conn.resp_body
      |> Poison.decode!
      |> Map.get("patient_ids") == []
    end
  end

  describe "routes with clinician return lists" do
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

      Repo.insert!(%EPJSUser{
        Patient_ID: 123,
        Forename: "kat",
        Surname: "bow"
        })

      :ok
    end

    test "GET /epjsteammember/clinician-connection/find-clinician?user_data=", %{conn: conn} do
      user_data = "UserName=robert_macmurray@nhs.co.uk&UserId=randomstringtotestwith&tokenexpiry=3000-06-23T11:15:53"
      conn = get conn, "/epjsteammember/clinician-connection/find-clinician?user_data=" <> user_data
      clinician = conn.resp_body
      |> Poison.decode!
      |> Map.get("clinician")
      |> Enum.at(0)
      assert clinician["Staff_ID"] == 321
    end

    test "GET /epjsteammember/clinician-connection/get-patients?clinician= returns expected data", %{conn: conn} do
      clinician = %{
        id: 321,
        first_name: "rob",
        last_name: "stallion",
        email: "rob@email.com",
        security_question: "Question?",
        security_answer: "Answer",
        role: "clinician",
        user_guid: "randomstringtotestwith"
      } |> Poison.encode!

      conn = get conn, "/epjsteammember/clinician-connection/get-patients?clinician=" <> clinician
      assert conn.resp_body
      |> Poison.decode!
      |> Map.get("patient_ids") == [123]
    end
  end
end
