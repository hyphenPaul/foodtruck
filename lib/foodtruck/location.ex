defmodule Foodtruck.Location do
  @moduledoc """
  A model of a foodtruck location
  """

  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "locations" do
    field(:address, :string)
    field(:applicant, :string)
    field(:approved, :string)
    field(:expirationdate, :string)
    field(:facilitytype, :string)
    field(:fire_prevention_districts, :string)
    field(:fooditems, :string)
    field(:latitude, :decimal)
    field(:location, :string)
    field(:locationdescription, :string)
    field(:longitude, :decimal)
    field(:noisent, :string)
    field(:neighborhoods_old, :string)
    field(:police_districts, :string)
    field(:priorpermit, :string)
    field(:received, :string)
    field(:schedule, :string)
    field(:status, :string)
    field(:supervisor_districts, :string)
    field(:x, :string)
    field(:y, :string)
    field(:zip_codes, :string)
    field(:block, :string)
    field(:blocklot, :string)
    field(:cnn, :string)
    field(:dayshours, :string)
    field(:locationid, :string)
    field(:lot, :string)
    field(:permit, :string)

    # Calculated using earth_distance in Postgres
    field(:distance_meters, :decimal, virtual: true)
  end

  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = foodtruck, attrs) do
    cast(foodtruck, attrs, __MODULE__.__schema__(:fields))
  end
end
