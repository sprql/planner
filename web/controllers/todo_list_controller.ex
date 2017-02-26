defmodule Planner.TodoListController do
  use Planner.Web, :controller

  alias Planner.TodoList
  alias Planner.Project

  plug :assign_project when action in [:index, :new, :create]
  plug :assign_current_todo_list when action in [:show, :edit, :update, :delete]

  def index(conn, _params) do
    todo_lists = Repo.all(TodoList)
    render(conn, "index.html", todo_lists: todo_lists)
  end

  def new(conn, _params) do
    changeset = TodoList.changeset(%TodoList{project_id: conn.assigns[:project].id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo_list" => todo_list_params}) do
    changeset = TodoList.changeset(%TodoList{}, todo_list_params)

    case Repo.insert(changeset) do
      {:ok, todo_list} ->
        conn
        |> put_flash(:info, "Todo list created successfully.")
        |> redirect(to: todo_list_path(conn, :show, todo_list))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo_list = Repo.get!(TodoList, id)
    render(conn, "show.html", todo_list: todo_list)
  end

  def edit(conn, %{"id" => id}) do
    todo_list = Repo.get!(TodoList, id)
    changeset = TodoList.changeset(todo_list)
    render(conn, "edit.html", todo_list: todo_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo_list" => todo_list_params}) do
    todo_list = Repo.get!(TodoList, id)
    changeset = TodoList.changeset(todo_list, todo_list_params)

    case Repo.update(changeset) do
      {:ok, todo_list} ->
        conn
        |> put_flash(:info, "Todo list updated successfully.")
        |> redirect(to: todo_list_path(conn, :show, todo_list))
      {:error, changeset} ->
        render(conn, "edit.html", todo_list: todo_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_list = Repo.get!(TodoList, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(todo_list)

    conn
    |> put_flash(:info, "Todo list deleted successfully.")
    |> redirect(to: project_path(conn, :show, todo_list.project_id))
  end

  defp assign_project(conn, _) do
    project = Repo.get!(Project, conn.params["project_id"])

    assign(conn, :project, project)
  end

  defp assign_current_todo_list(conn, _) do
    todo_list =
      Repo.get!(TodoList, conn.params["id"])
      |> Repo.preload([:project])

    conn = assign(conn, :todo_list, todo_list)
    assign(conn, :project, todo_list.project)
  end
end
