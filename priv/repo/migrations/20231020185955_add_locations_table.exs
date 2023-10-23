defmodule Foodtruck.Repo.Migrations.AddLocationsTable do
  use Ecto.Migration

  def change do
    create table("locations") do
      add(:address, :string)
      add(:applicant, :string)
      add(:approved, :string)
      add(:expirationdate, :string)
      add(:facilitytype, :string)
      add(:fire_prevention_districts, :string)
      add(:fooditems, :string)
      add(:location, :string)
      add(:latitude, :decimal, precision: 20, scale: 10)
      add(:longitude, :decimal, precision: 20, scale: 10)
      add(:locationdescription, :string)
      add(:noisent, :string)
      add(:neighborhoods_old, :string)
      add(:police_districts, :string)
      add(:priorpermit, :string)
      add(:received, :string)
      add(:schedule, :string)
      add(:status, :string)
      add(:supervisor_districts, :string)
      add(:x, :string)
      add(:y, :string)
      add(:zip_codes, :string)
      add(:block, :string)
      add(:blocklot, :string)
      add(:cnn, :string)
      add(:dayshours, :string)
      add(:locationid, :string)
      add(:lot, :string)
      add(:permit, :string)
    end
  end
end
