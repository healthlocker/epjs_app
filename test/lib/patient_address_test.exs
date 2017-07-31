defmodule EpjsApp.PatientAddressTest do
  use EpjsApp.ModelCase, async: true
  alias EpjsApp.{EPJSPatientAddressDetails, PatientAddress, Repo}

  describe "with valid address in DB" do
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

    test "get address responds with address when given valid data" do
      address = PatientAddress.get_address(%{"slam_id" => 123})
      assert address."Address_ID" == 1
    end
  end

  describe "without valid address in DB" do
    test "get address responds with nil when given invalid data" do
      address = PatientAddress.get_address(%{"slam_id" => 123})
      assert address == nil
    end
  end
end
