defmodule Planner.Project do
  use Planner.Web, :model

  schema "projects" do
    field :name, :string
    field :tags, Planner.Tags, default: []
    has_many :todo_lists, Planner.Project

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :tags])
    |> validate_required([:name])
  end
end
