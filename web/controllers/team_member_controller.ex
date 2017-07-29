defmodule EpjsApp.TeamMemberController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{ClinicianConnection}

  def find_clinician(conn, %{"user_data" => user_data}) do
    decrypted_user_data = user_data
    |> ClinicianConnection.find_clinician

    json conn, decrypted_user_data
  end

  def get_patients(conn, %{"clinician" => clinician}) do
    patient_details = clinician
    |> Poison.decode
    |> ClinicianConnection.get_patients

    json conn, patient_details
  end
end
