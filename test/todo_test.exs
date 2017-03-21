defmodule Planner.TodoTest do
  use Planner.DataCase

  alias Planner.Todo
  alias Planner.Todo.Project

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:project, attrs \\ @create_attrs) do
    {:ok, project} = Todo.create_project(attrs)
    project
  end

  test "list_projects/1 returns all projects" do
    project = fixture(:project)
    assert Todo.list_projects() == [project]
  end

  test "get_project! returns the project with given id" do
    project = fixture(:project)
    assert Todo.get_project!(project.id) == project
  end

  test "create_project/1 with valid data creates a project" do
    assert {:ok, %Project{} = project} = Todo.create_project(@create_attrs)
    
    assert project.name == "some name"
  end

  test "create_project/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Todo.create_project(@invalid_attrs)
  end

  test "update_project/2 with valid data updates the project" do
    project = fixture(:project)
    assert {:ok, project} = Todo.update_project(project, @update_attrs)
    assert %Project{} = project
    
    assert project.name == "some updated name"
  end

  test "update_project/2 with invalid data returns error changeset" do
    project = fixture(:project)
    assert {:error, %Ecto.Changeset{}} = Todo.update_project(project, @invalid_attrs)
    assert project == Todo.get_project!(project.id)
  end

  test "delete_project/1 deletes the project" do
    project = fixture(:project)
    assert {:ok, %Project{}} = Todo.delete_project(project)
    assert_raise Ecto.NoResultsError, fn -> Todo.get_project!(project.id) end
  end

  test "change_project/1 returns a project changeset" do
    project = fixture(:project)
    assert %Ecto.Changeset{} = Todo.change_project(project)
  end
end
