defmodule Planner.Repo.Migrations.CreatePlanner.Todo.List do
  use Ecto.Migration

  def change do
    create table(:todo_lists, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :project_id, references(:projects, on_delete: :nothing, type: :uuid)
      add :name, :string
      add :description, :text
      add :position, :integer
      add :state, :string

      timestamps()
    end

    create index(:todo_lists, [:project_id])
  end
end

