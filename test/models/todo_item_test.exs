defmodule Planner.TodoItemTest do
  use Planner.ModelCase

  alias Planner.TodoItem

  @valid_attrs %{content: "some content", position: 42, state: "some state"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TodoItem.changeset(%TodoItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TodoItem.changeset(%TodoItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
