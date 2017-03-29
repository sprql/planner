import EctoEnum
defenum ItemStates, todo: 0, done: 1

defmodule Planner.Todo.Item do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "todo_items" do
    field :content, :string
    field :tags, Planner.Tags, default: []
    field :state, ItemStates
    field :done, :boolean, virtual: true
    field :position, :integer

    timestamps()
  end
end
