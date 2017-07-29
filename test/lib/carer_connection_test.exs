defmodule EpjsApp.CarerConnectionTest do
  use EpjsApp.ModelCase, async: true
  alias EpjsApp.{CarerConnection, EPJSUser, Repo}

  setup %{} do
    Repo.insert!(%EPJSUser{
      Patient_ID: 200,
      Surname: "Bow",
      Forename: "Kat",
      NHS_Number: "uvhjbfnwqoekhfg8y9i",
      DOB: DateTime.from_naive!(~N[1989-01-01 00:00:00.00], "Etc/UTC"),
    })

    :ok
  end

  describe "find_epjs_user" do
    test "gets user from db if details are valid" do
      stringified_changeset = "{\"validations\":[],\"valid?\":true,\"types\":{\"surname\":\"string\",\"nhs_number\":\"string\",\"id\":\"binary_id\",\"forename\":\"string\",\"epjs_patient_id\":\"integer\",\"date_of_birth\":\"string\"},\"required\":[\"forename\",\"surname\",\"date_of_birth\",\"nhs_number\"],\"repo\":null,\"prepare\":[],\"params\":{\"surname\":\"Bow\",\"nhs_number\":\"uvhjbfnwqoekhfg8y9i\",\"forename\":\"Kat\",\"date_of_birth\":\"01/01/1989\"},\"filters\":{},\"errors\":[],\"empty_values\":[\"\"],\"data\":{\"surname\":null,\"nhs_number\":null,\"id\":null,\"forename\":null,\"epjs_patient_id\":null,\"date_of_birth\":null},\"constraints\":[],\"changes\":{\"surname\":\"Bow\",\"nhs_number\":\"uvhjbfnwqoekhfg8y9i\",\"forename\":\"Kat\",\"date_of_birth\":\"1989-01-01T00:00:00Z\"},\"action\":null}"
      changeset = Poison.decode!(stringified_changeset)
      user_forename =
        CarerConnection.find_epjs_user(changeset)
        |> Map.get(:Forename)
      assert user_forename == "Kat"
    end
  end
end
