defmodule EpjsApp.PatientAddress do
  alias EpjsApp.{Repo, EPJSPatientAddressDetails}
  import Ecto.Query

  def get_address(%{"slam_id" => slam_id}) do
    query = from e in EPJSPatientAddressDetails,
      where: e."Patient_ID" == ^slam_id

      Repo.one(query)
  end
end
