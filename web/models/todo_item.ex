defmodule Planner.TodoItem do
  use Planner.Web, :model

  schema "todo_items" do
    field :content, :string
    field :state, :string
    field :position, :integer
    belongs_to :todo_list, Planner.TodoList

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:todo_list_id, :content, :state, :position])
    |> validate_required([:todo_list_id, :content])
  end
end
