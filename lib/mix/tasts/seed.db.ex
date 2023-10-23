defmodule Mix.Tasks.Seed.Db do
  @moduledoc """
  A task to data from a CSV hosted @ https://data.sfgov.org/api/views/rqzj-sfat/rows.csv and populate the database.

  Example:
  ```
  mix seed.db
  ```
  """

  @csv_url "https://data.sfgov.org/api/views/rqzj-sfat/rows.csv"

  alias Foodtruck.Context.Locations

  @doc """
  The functions starts the application, fetches the CSV
  data and inserts it into a fresh database.
  """
  def run(_args) do
    Application.ensure_all_started(:foodtruck)

    case get_csv(@csv_url) do
      {:ok, body} ->
        # Truncate the database
        Locations.truncate()

        # Insert locatios from the csv
        [body]
        |> CSV.decode(headers: true)
        |> Stream.map(&elem(&1, 1))
        |> Stream.map(&underscore_keys/1)
        |> Stream.each(&Locations.create/1)
        |> Stream.run()

      {:error, error} ->
        IO.puts("an error occurred:\n #{error}")
    end
  end

  @spec get_csv(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  defp get_csv(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{status_code: code}} -> {:error, "Unexpected status code: #{code}"}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  @spec underscore_keys(map()) :: map()
  defp underscore_keys(location) do
    Enum.map(location, fn {k, v} -> {underscore_key(k), v} end) |> Map.new()
  end

  @spec underscore_key(String.t()) :: String.t()
  defp underscore_key(key) do
    key
    |> Phoenix.Naming.underscore()
    |> String.replace(" ", "")
  end
end
