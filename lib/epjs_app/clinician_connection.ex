defmodule EpjsApp.ClinicianConnection do
  import Ecto.Query
  alias EpjsApp.{EPJSUser, EPJSTeamMember, Repo, DecryptUser}

  def find_clinician(user_data) do
    [decrypted_user_guid, decrypted_time_str] = DecryptUser.decrypt_user_data(user_data)
    query = from etm in EPJSTeamMember, where: etm."User_Guid" == ^decrypted_user_guid

    %{decrypted_time_str: decrypted_time_str, decrypted_user_guid: decrypted_user_guid, clinician: Repo.all(query)}
  end

  def get_patients(%{"clinician" => clinician}) do
    ids_query = from e in EPJSTeamMember,
        where: e."Email" == ^clinician.email,
        select: e."Patient_ID"
    patient_ids = Repo.all(ids_query)

    patients = patient_ids
    |> Enum.map(fn id ->
      Repo.all(from e in EPJSUser,
      where: e."Patient_ID" == ^id)
    end)

    %{patient_ids: patient_ids, patients: patients}
  end
end
