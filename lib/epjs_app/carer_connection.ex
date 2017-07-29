defmodule EpjsApp.CarerConnection do
  import Ecto.Query
  alias EpjsApp.{EPJSUser, Repo}

  def find_epjs_user(%{"changes" => changes}) do
    %{"forename" => forename, "surname" => surname, "date_of_birth" => date_of_birth, "nhs_number" => nhs_number} = changes

    query = from e in EPJSUser,
      where: e."Forename" == ^forename
        and e."Surname" == ^surname
        and e."DOB" == ^date_of_birth
        and e."NHS_Number" == ^nhs_number

    Repo.one(query)
  end

  def find_epjs_user(%{"service_user" => service_user}) do
    query = from e in EPJSUser,
      where: e."Patient_ID" == ^service_user.slam_id)

    Repo.one(query)
  end

end
