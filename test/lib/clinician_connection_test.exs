defmodule EpjsApp.ClinicianConnectionTest do
  use EpjsApp.ModelCase, async: true
  alias EpjsApp.{ClinicianConnection, EPJSUser, EPJSTeamMember, Repo}

  describe "correct clinician is not in the db" do
    test "does not find clinician with incorrect data" do
      user_data = "UserName=robert_macmurray@nhs.co.uk&UserId=badstring&tokenexpiry=3000-06-23T11:15:53"
      result = ClinicianConnection.find_clinician(user_data)
      assert result.decrypted_user_guid == "randomstringtotestwith"
      assert result.decrypted_time_str == "3000-06-23T11:15:53"
      assert result.clinician == []
    end

    test "does not get patients for non-existent clinician email" do
      email = %{"email" => "wrong@email.com"}
      result = ClinicianConnection.get_patients(email)
      assert result.patient_ids == []
      assert result.patients == []
    end
  end

  describe "clinician info is correct and in db" do
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
          Surname: "Bow",
          Forename: "Kat",
          NHS_Number: "1234567890",
          DOB: DateTime.from_naive!(~N[1989-01-01 00:00:00.00], "Etc/UTC"),
        })

        :ok
    end

    test "finds clinician with correct data" do
      user_data = "UserName=robert_macmurray@nhs.co.uk&UserId=randomstringtotestwith&tokenexpiry=3000-06-23T11:15:53"
      result = ClinicianConnection.find_clinician(user_data)
      assert result.decrypted_user_guid == "randomstringtotestwith"
      assert result.decrypted_time_str == "3000-06-23T11:15:53"
      assert result.clinician
      |> Enum.at(0)
      |> Map.get(:Staff_Name) == "rob stallion"
    end

    test "gets patients for a clinician by correct email" do
      email = %{"email" => "rob@email.com"}
      result = ClinicianConnection.get_patients(email)
      assert result.patient_ids == [123]
      assert result.patients
      |> Enum.at(0)
      |> Map.get(:NHS_Number) == "1234567890"
    end
  end
end
