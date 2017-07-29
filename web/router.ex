defmodule EpjsApp.Router do
  use EpjsApp.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EpjsApp do
    pipe_through :api

    get "/user/carer-connection/find-user", UserController, :find_user
    get "/team-member/care-team/for", TeamMemberController, :for
    get "/team-member/clinician-connection/find-clinician", TeamMemberController, :find_clinician
    get "/team-member/clinician-connection/get-patients", TeamMemberController, :get_patients
    get "/patient-address-details/address/get-address", AddressController, :get_address

  end
end
