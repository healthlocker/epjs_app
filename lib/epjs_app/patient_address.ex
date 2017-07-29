defmodule EpjsApp.PatientAddress do
  alias EpjsApp.{EPJSTeamMember, Repo, EPJSPatientAddressDetails}
  import Ecto.Query

  def for(user) do
    query = from e in EPJSTeamMember,
      where: e."Patient_ID" == ^user.slam_id

    Repo.all(query)
  end

  def get_address(%{"service_user" => service_user}) do
    query = from e in EPJSPatientAddressDetails,
      where: e."Patient_ID" == ^service_user.slam_id

      Repo.one(query)
  end
end
