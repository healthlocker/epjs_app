defmodule EpjsApp.AddressControllerTest do
  use EpjsApp.ConnCase
  alias EpjsApp.{EPJSPatientAddressDetails, Repo}

  setup %{} do
    Repo.insert!(%EPJSPatientAddressDetails{
      Address_ID: 1,
      Patient_ID: 123,
      Address1: "123 fake st",
      Address2: "London",
      Post_Code: "E2 0SY",
      Email_Address: "email@email.com"
    })

    :ok
  end

  describe "address controller returns json response with valid slam_id" do
    test "GET /epjspatientaddressdetails/address/get-address?service_user", %{conn: conn} do
      stringified_user = %{slam_id: 123} |> Poison.encode!
      conn = get conn, "http://localhost:4001/epjspatientaddressdetails/address/get-address?service_user=" <> stringified_user
      assert json_response(conn, 200)
    end
  end

  describe "address controller returns null json response with invalid slam_id" do
    test "GET /epjspatientaddressdetails/address/get-address?service_user", %{conn: conn} do
      stringified_user = %{slam_id: 456} |> Poison.encode!
      conn = get conn, "http://localhost:4001/epjspatientaddressdetails/address/get-address?service_user=" <> stringified_user
      assert conn.resp_body == "null"
    end
  end
end
