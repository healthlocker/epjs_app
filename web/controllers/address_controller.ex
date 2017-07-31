defmodule EpjsApp.AddressController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{PatientAddress}

  def get_address(conn, %{"service_user" => service_user}) do
    address =
      service_user
      |> Poison.decode!
      |> PatientAddress.get_address

    json conn, address
  end
end
