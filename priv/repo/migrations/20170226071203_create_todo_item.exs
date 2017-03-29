defmodule Planner.Repo.Migrations.CreatePlanner.Todo.Item do
  use Ecto.Migration

  def change do
    create table(:todo_items, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :content, :text
      add :tags, {:array, :string}, default: []
      add :state, :integer, default: 0
      add :position, :integer

      timestamps()
    end
  end
end
