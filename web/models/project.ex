defmodule Planner.Project do
  use Planner.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "projects" do
    field :name, :string
    field :tags, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
