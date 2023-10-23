defmodule Foodtruck.Context.Locations do
  @moduledoc """
  A context module for Locations
  """

  import Ecto.Query

  alias Ecto.Adapters.SQL
  alias Foodtruck.Location
  alias Foodtruck.Repo

  @doc """
  Get all locations with options to filter.

  Filter:
  Filter the query using a map of locations keys
  which always query with AND logic, not OR.

  Distance Calulation:
  Calculate the distance in meters and populate the
  distance_meters virtual field when the "user_lat" and 
  "user_long" keys are populated
  """
  @spec get_all(map()) :: [Location.t()]
  def get_all(params) do
    base_query()
    |> filter(params)
    |> calculate_distance(params)
    |> Repo.all()
  end

  @doc """
  Get a single location by passing the map id value for the locationid
  """
  @spec get(map()) :: Location.t() | nil
  def get(%{"id" => id}) do
    base_query()
    |> where_id(id)
    |> Repo.one()
  end

  @doc """
  Create a location
  """
  @spec create(map()) :: {:ok, Location.t()} | {:error, Ecto.Changeset.t()}
  def create(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert(returning: true)
  end

  @doc """
  Truncate the database
  """
  @spec truncate :: any()
  def truncate do
    SQL.query!(Repo, "TRUNCATE locations", [])
  end

  @doc """
  Query used as the base for Ecto composed queries
  """
  @spec base_query :: Ecto.Query.t()
  def base_query, do: from(_ in Location)

  @spec calculate_distance(Ecto.Query.t(), map()) :: Ecto.Query.t()
  defp calculate_distance(query, %{"user_lat" => user_lat, "user_long" => user_long}) do
    query
    |> select_merge(%{distance_meters: fragment("earth_distance(
      ll_to_earth(?, ?),
      ll_to_earth(latitude, longitude)
    ) as distance_meters", ^user_lat, ^user_long)})
    |> order_by(fragment("distance_meters ASC"))
  end

  defp calculate_distance(query, _), do: query

  @spec filter(Ecto.Query.t(), map()) :: Ecto.Query.t()
  defp filter(query, params) do
    if params == %{} do
      query
    else
      schema_fields = :fields |> Location.__schema__() |> Enum.map(&to_string/1)

      filters =
        params
        |> Enum.filter(fn {k, _} -> Enum.member?(schema_fields, k) end)
        |> Map.new()

      Enum.reduce(filters, query, fn {k, v}, acc ->
        from(q in acc, where: field(q, ^String.to_atom(k)) == ^v)
      end)
    end
  end

  @spec where_id(Ecto.Query.t(), String.t()) :: Ecto.Query.t()
  defp where_id(query, id), do: from(q in query, where: q.locationid == ^id)
end
