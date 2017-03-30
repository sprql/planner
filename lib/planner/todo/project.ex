defmodule Planner.Todo.Project do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "projects" do
    field :name, :string
    has_many :todo_lists, Planner.Todo.List

    timestamps()
  end
end
