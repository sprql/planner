defmodule Planner.Todo do
  @moduledoc """
  The boundary for the Todo system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Planner.Repo

  alias Planner.Todo.Project

  def list_projects do
    Repo.all(Project)
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def create_project(attrs \\ %{}) do
    %Project{}
    |> project_changeset(attrs)
    |> Repo.insert()
  end

  def update_project(%Project{} = project, attrs) do
    project
    |> project_changeset(attrs)
    |> Repo.update()
  end

  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  def change_project(%Project{} = project) do
    project_changeset(project, %{})
  end

  defp project_changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:name, :tags])
    |> validate_required([:name])
  end

  alias Planner.Todo.List

  def project_todo_lists(project) do
    Repo.preload(project, :todo_lists).todo_lists()
  end

  def get_todo_list!(id) do
    List
    |> Repo.get!(id)
    |> Repo.preload(:project)
  end

  def preload_todo_list(%List{} = todo_list) do
    todo_list
    |> Repo.preload(:todo_items)
    |> Repo.preload(project: :todo_lists)
  end

  def create_todo_list(attrs \\ %{}) do
    %List{}
    |> todo_list_changeset(attrs)
    |> Repo.insert()
  end

  def update_todo_list(%List{} = list, attrs) do
    list
    |> todo_list_changeset(attrs)
    |> Repo.update()
  end

  def delete_todo_list(%List{} = list) do
    Repo.delete(list)
  end

  def new_project_todo_list(%Project{} = project) do
    todo_list_changeset(%List{}, %{project_id: project.id})
  end

  def change_todo_list(%List{} = list) do
    todo_list_changeset(list, %{})
  end

  defp todo_list_changeset(%List{} = list, attrs) do
    list
    |> cast(attrs, [:project_id, :name, :description, :position, :state])
    |> validate_required([:project_id, :name])
  end

  alias Planner.Todo.Item

  def todo_list_items(%List{} = todo_list) do
    Repo.preload(todo_list, :todo_items).todo_items
  end

  def get_todo_item!(id) do
    Item
    |> Repo.get!(id)
    |> Repo.preload(todo_list: :project)
  end

  def create_todo_item(attrs \\ %{}) do
    %Item{}
    |> item_changeset(attrs)
    |> Repo.insert()
  end

  def update_todo_item(%Item{} = item, attrs) do
    item
    |> item_changeset(attrs)
    |> Repo.update()
  end

  def delete_todo_item(%Item{} = item) do
    Repo.delete(item)
  end

  def change_todo_item(%Item{} = item) do
    item_changeset(item, %{})
  end

  def todo_list_change_item(%List{} = todo_list) do
    item_changeset(%Item{}, %{todo_list_id: todo_list.id})
  end

  defp item_changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:todo_list_id, :content, :state, :position])
    |> validate_required([:todo_list_id, :content])
  end
end
