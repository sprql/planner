defmodule Planner.TodoListTest do
  use Planner.ModelCase

  alias Planner.TodoList

  @valid_attrs %{description: "some description", name: "some name", position: 42, project_id: "7488a646-e31f-11e4-aace-600308960662", state: "some state"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TodoList.changeset(%TodoList{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TodoList.changeset(%TodoList{}, @invalid_attrs)
    refute changeset.valid?
  end
end
