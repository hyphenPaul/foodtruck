defmodule MyApp.Repo.Migrations.EnableEarthdistance do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS cube"
    execute "CREATE EXTENSION IF NOT EXISTS earthdistance"
  end

  def down do
    execute "DROP EXTENSION IF EXISTS cube"
    execute "DROP EXTENSION IF EXISTS earthdistance"
  end
end
