defmodule EpjsApp.EPJSTeamMember do
  use EpjsApp.Web, :model

  @primary_key {:Staff_ID, :integer, autogenerate: false}
  schema "mhlTeamMembers" do
    field :Patient_ID, :integer
    field :Staff_Name, :string
    field :Job_Title, :string
    field :Team_Member_Role_Desc, :string
    field :Email, :string
    field :User_Guid, :string
  end

  def changeset(struct, params \\ :invalid) do
    struct
    |> cast(params, [:Patient_ID, :Staff_ID])
  end

  def patient_ids(query, clinician_email) do
    from e in query,
    where: e."Email" == ^clinician_email,
    select: e."Patient_ID"
  end
end
