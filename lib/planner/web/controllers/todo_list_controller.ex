defmodule Planner.Web.TodoListController do
  use Planner.Web, :controller

  alias Planner.Todo
  alias Planner.Todo.List

  plug :assign_project when action in [:index, :new, :create]
  plug :assign_todo_list when action in [:show, :edit, :update, :delete]

  def index(conn, _params) do
    todo_lists = Todo.project_todo_lists(conn.assign.project)
    render(conn, "index.html", todo_lists: todo_lists)
  end

  def new(conn, _params) do
    changeset = Todo.new_project_todo_list(conn.assigns[:project])
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list" => todo_list_params}) do
    case Todo.create_todo_list(todo_list_params) do
      {:ok, todo_list} ->
        conn
        |> put_flash(:info, "Todo list created successfully.")
        |> redirect(to: todo_list_path(conn, :show, todo_list))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _) do
    render(conn, "show.html")
  end

  def edit(conn, %{"id" => id}) do
    todo_list = Todo.get_todo_list!(id)
    changeset = Todo.change_todo_list(todo_list)
    render(conn, "edit.html", todo_list: todo_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list" => todo_list_params}) do
    todo_list = Todo.get_todo_list!(id)

    case Todo.update_todo_list(todo_list, todo_list_params) do
      {:ok, todo_list} ->
        conn
        |> put_flash(:info, "Todo list updated successfully.")
        |> redirect(to: todo_list_path(conn, :show, todo_list))
      {:error, changeset} ->
        render(conn, "edit.html", todo_list: todo_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_list = Repo.get!(Todo.List, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(todo_list)

    conn
    |> put_flash(:info, "Todo list deleted successfully.")
    |> redirect(to: project_path(conn, :show, todo_list.project_id))
  end

  defp assign_project(conn, _) do
    project = Todo.get_project!(conn.params["project_id"])

    assign(conn, :project, project)
  end

  defp assign_todo_list(conn, _) do
    todo_list = Todo.get_todo_list!(conn.params["id"])

    conn
    |> assign(:todo_list, todo_list)
    |> assign(:project, todo_list.project)
  end
end
