defmodule EpjsApp.TeamMemberController do
  use EpjsApp.Web, :controller
  alias EpjsApp.{ClinicianConnection, CareTeam}

  def find_clinician(conn, %{"user_data" => user_data}) do
    decrypted_user_data = user_data
    |> ClinicianConnection.find_clinician

    json conn, decrypted_user_data
  end

  def get_patients(conn, %{"clinician" => clinician}) do
    patient_details = clinician
    |> Poison.decode!
    |> ClinicianConnection.get_patients

    json conn, patient_details
  end

  def for(conn, %{"service_user" => service_user}) do
    care_team =
      service_user
      |> Poison.decode!
      |> CareTeam.for
    json conn, care_team
  end
end
