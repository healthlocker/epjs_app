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

  describe "find_user" do
    test "gets user from db if details are valid" do
      stringified_changeset = "{\"surname\":\"Bow\",\"nhs_number\":\"uvhjbfnwqoekhfg8y9i\",\"forename\":\"Kat\",\"date_of_birth\":\"1989-01-01T00:00:00Z\"}"
      changeset = Poison.decode!(stringified_changeset)
      user_forename =
        CarerConnection.find_user(changeset)
        |> Map.get(:Forename)
      assert user_forename == "Kat"
    end

    test "gets nil if details are invalid" do
      stringified_changeset = "{\"surname\":\"Name\",\"nhs_number\":\"uvhjbfnwqoekhfg8y9i\",\"forename\":\"Wrong\",\"date_of_birth\":\"1989-01-01T00:00:00Z\"}"
      changeset = Poison.decode!(stringified_changeset)
      result = CarerConnection.find_user(changeset)
      assert result == nil
    end
  end
end
