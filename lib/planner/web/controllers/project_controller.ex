defmodule Planner.Web.ProjectController do
  use Planner.Web, :controller

  alias Planner.Todo
  alias Planner.Todo.Project

  plug :assign_nil_project when action in [:index, :new, :create]

  def index(conn, _params) do
    projects = Todo.list_projects()
    render(conn, "index.html", projects: projects)
  end

  def new(conn, _params) do
    changeset = Todo.change_project(%Project{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"project" => project_params}) do
    case Todo.create_project(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: project_path(conn, :show, project))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Todo.get_project!(id)
    todo_lists = Todo.project_todo_lists_with_items(project)

    render(conn, "show.html", project: project, todo_lists: todo_lists)
  end

  def edit(conn, %{"id" => id}) do
    project = Todo.get_project!(id)
    changeset = Todo.change_project(project)
    render(conn, "edit.html", project: project, changeset: changeset)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Todo.get_project!(id)

    case Todo.update_project(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: project_path(conn, :show, project))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Todo.get_project!(id)
    {:ok, _project} = Todo.delete_project(project)

    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: project_path(conn, :index))
  end

  defp assign_nil_project(conn, _opts) do
    assign(conn, :project, nil)
  end
end
