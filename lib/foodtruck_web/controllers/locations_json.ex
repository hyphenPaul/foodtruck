defmodule FoodtruckWeb.LocationsJSON do
  alias Foodtruck.Location

  @doc """
  Renders a list of locations
  """
  def index(%{locations: locations}) do
    for(location <- locations, do: data(location))
  end

  @doc """
  Renders a single location.
  """
  def show(%{location: location}) do
    data(location)
  end

  defp data(%Location{} = location) do
    %{
      address: location.address,
      applicant: location.applicant,
      approved: location.approved,
      expirationdate: location.expirationdate,
      facilitytype: location.facilitytype,
      fire_prevention_districts: location.fire_prevention_districts,
      fooditems: location.fooditems,
      latitude: location.latitude,
      location: location.location,
      locationdescription: location.locationdescription,
      longitude: location.longitude,
      noisent: location.noisent,
      neighborhoods_old: location.neighborhoods_old,
      police_districts: location.police_districts,
      priorpermit: location.priorpermit,
      received: location.received,
      schedule: location.schedule,
      status: location.status,
      supervisor_districts: location.supervisor_districts,
      x: location.x,
      y: location.y,
      zip_codes: location.zip_codes,
      block: location.block,
      blocklot: location.blocklot,
      cnn: location.cnn,
      dayshours: location.dayshours,
      locationid: location.locationid,
      lot: location.lot,
      permit: location.permit
    }
  end
end
