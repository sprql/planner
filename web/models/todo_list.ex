defmodule Planner.TodoList do
  use Planner.Web, :model

  schema "todo_lists" do
    field :name, :string
    field :description, :string
    field :position, :integer, default: 0
    field :state, :string
    belongs_to :project, Planner.Project
    has_many :todo_items, Planner.TodoItem

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:project_id, :name, :description, :position, :state])
    |> validate_required([:project_id, :name])
  end
end
