defmodule EpjsApp.UserControllerTest do
  use EpjsApp.ConnCase
  alias EpjsApp.{EPJSUser, Repo}

  describe "epjs user is inserted into the db" do
    setup %{} do
      Repo.insert!(%EPJSUser{
        Patient_ID: 123,
        Forename: "Kat",
        Surname: "Bow",
        DOB: DateTime.from_naive!(~N[1989-01-01 00:00:00.00], "Etc/UTC"),
        NHS_Number: "1234567890"
        })
      :ok
    end

    test "GET /user/carer-connection/find-user returns epjs user with valid info", %{conn: conn} do
      changeset = %{
        forename: "Kat",
        surname: "Bow",
        date_of_birth: DateTime.from_naive!(~N[1989-01-01 00:00:00.00], "Etc/UTC"),
        nhs_number: "1234567890"
      } |> Poison.encode!
      conn = get conn, "/user/carer-connection/find-user?changeset=" <> changeset
      assert conn.resp_body
      |> Poison.decode!
      |> Map.get("Patient_ID") == 123
    end

    test "GET /user/carer-connection/find-user returns epjs user with invalid info", %{conn: conn} do
      changeset = %{
        forename: "Wrong",
        surname: "Name",
        date_of_birth: DateTime.from_naive!(~N[1989-01-01 00:00:00.00], "Etc/UTC"),
        nhs_number: "1234567890"
      } |> Poison.encode!
      conn = get conn, "/user/carer-connection/find-user?changeset=" <> changeset
      assert conn.resp_body
      |> Poison.decode! == nil
    end
  end
end
