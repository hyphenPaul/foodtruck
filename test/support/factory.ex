defmodule Foodtruck.Factory do
  @moduledoc """
  A module for handling test factories.
  """

  alias Foodtruck.Repo

  def build(:location) do
    %Foodtruck.Location{}
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!(returning: true)
  end
end
