defmodule Planner.Todo.ItemTest do
  use Planner.ModelCase

  alias Planner.Todo.Item

  @valid_attrs %{content: "some content", position: 42, state: "some state"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Todo.Item.changeset(%Todo.Item{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Todo.Item.changeset(%Todo.Item{}, @invalid_attrs)
    refute changeset.valid?
  end
end
