defmodule Planner.Repo.Migrations.CreatePlanner.Todo.Project do
  use Ecto.Migration

  def change do
    create table(:projects, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :name, :string

      timestamps()
    end
  end
end

