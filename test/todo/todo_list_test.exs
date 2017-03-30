defmodule Planner.Todo.ListTest do
  use Planner.ModelCase

  alias Planner.Todo.List

  @valid_attrs %{description: "some description", name: "some name", position: 42, project_id: "7488a646-e31f-11e4-aace-600308960662", state: "some state"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Todo.List.changeset(%Todo.List{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Todo.List.changeset(%Todo.List{}, @invalid_attrs)
    refute changeset.valid?
  end
end
