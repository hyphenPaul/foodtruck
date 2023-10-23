defmodule Foodtruck.LocationTest do
  use ExUnit.Case

  alias Foodtruck.Location

  describe "changeset/2" do
    test "creates a changeset" do
      assert %Ecto.Changeset{} = Location.changeset(%Location{}, %{})
    end

    test "creates a valid changeset" do
      assert result = %Ecto.Changeset{} = Location.changeset(%Location{}, %{address: "foo"})
      assert result.valid?
    end

    test "creates a invalid changeset" do
      assert result = %Ecto.Changeset{} = Location.changeset(%Location{}, %{address: 1})
      refute result.valid?
    end
  end
end
