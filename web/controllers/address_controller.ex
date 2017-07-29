defmodule EpjsApp.AddressController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{PatientAddress, CareTeam}

  def for(conn, %{"service_user" => service_user}) do
  # pattern matches against params for the service user,
  # grabs the data and then uses it to make a call to EJPS DB
    params = service_user |> Poison.decode!
    %{"slam_id" => slam_id} = params
    care_team = CareTeam.for(%{slam_id: slam_id})
    json conn, care_team
  end

  def get_address(conn, %{"service_user" => service_user}) do
    address =
      service_user
      |> Poison.decode!
      |> PatientAddress.get_address

    json conn, address
  end
end
