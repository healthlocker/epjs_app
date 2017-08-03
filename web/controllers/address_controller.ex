defmodule EpjsApp.AddressController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{PatientAddress}
  import EpjsApp.Encoder, only: [sanitize_map: 1]

  def get_address(conn, %{"service_user" => service_user}) do
    address =
      service_user
      |> Poison.decode!
      |> PatientAddress.get_address
      |> sanitize_map

    json conn, address
  end
end
