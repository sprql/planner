defmodule Planner.Repo.Migrations.CreatePlanner.Todo.Item do
  use Ecto.Migration

  def change do
    create table(:todo_items, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :todo_list_id, references(:todo_lists, on_delete: :nothing, type: :uuid)
      add :content, :text
      add :state, :string, default: "open"
      add :position, :integer

      timestamps()
    end

    create index(:todo_items, [:todo_list_id])
  end
end

