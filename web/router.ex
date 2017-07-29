defmodule EpjsApp.Router do
  use EpjsApp.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EpjsApp do
    pipe_through :api

    get "/care-team/for", CareTeamController, :for
    get "/epjsuser/carer-connection/find-epjs-user", EpjsUserController, :find_epjs_user
    get "/epjsteammember/clinician-connection/find-clinician", EpjsTeamMemberController, :find_clinician
    get "/epjsteammember/clinician-connection/get-patients", EpjsTeamMemberController, :get_patients
    get "/epjspatientaddressdetails/address/get-address", AddressController, :get_address

  end
end
