defmodule Planner.Todo.List do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "todo_lists" do
    field :name, :string
    field :description, :string
    field :position, :integer, default: 0
    field :state, :string
    belongs_to :project, Planner.Todo.Project
    has_many :todo_items, Planner.Todo.Item, foreign_key: :todo_list_id

    timestamps()
  end
end
