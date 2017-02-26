defmodule Planner.TodoItemController do
  use Planner.Web, :controller

  alias Planner.TodoItem
  alias Planner.TodoList

  plug :assign_current_todo_list when action in [:index, :new, :create]
  plug :assign_current_todo_item when action in [:show, :edit, :update, :delete]

  def index(conn, _params) do
    todo_item = Repo.all(TodoItem)
    render(conn, "index.html", todo_item: todo_item)
  end

  def new(conn, _params) do
    changeset = TodoItem.changeset(%TodoItem{todo_list_id: conn.assigns[:todo_list].id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo_item" => todo_item_params}) do
    changeset = TodoItem.changeset(%TodoItem{}, todo_item_params)

    case Repo.insert(changeset) do
      {:ok, todo_item} ->
        conn
        |> put_flash(:info, "Todo item created successfully.")
        |> redirect(to: todo_item_path(conn, :show, todo_item))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo_item = Repo.get!(TodoItem, id)
    render(conn, "show.html", todo_item: todo_item)
  end

  def edit(conn, %{"id" => id}) do
    todo_item = Repo.get!(TodoItem, id)
    changeset = TodoItem.changeset(todo_item)
    render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo_item" => todo_item_params}) do
    todo_item = Repo.get!(TodoItem, id)
    changeset = TodoItem.changeset(todo_item, todo_item_params)

    case Repo.update(changeset) do
      {:ok, todo_item} ->
        conn
        |> put_flash(:info, "Todo item updated successfully.")
        |> redirect(to: todo_item_path(conn, :show, todo_item))
      {:error, changeset} ->
        render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_item = Repo.get!(TodoItem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(todo_item)

    conn
    |> put_flash(:info, "Todo item deleted successfully.")
    |> redirect(to: todo_list_path(conn, :show, todo_item.todo_list_id))
  end

  defp assign_current_todo_list(conn, _) do
    todo_list =
      Repo.get!(TodoList, conn.params["todo_list_id"])
      |> Repo.preload([:project])

    conn = assign(conn, :todo_list, todo_list)
    assign(conn, :project, todo_list.project)
  end

  defp assign_current_todo_item(conn, _) do
    todo_item =
      Repo.get!(TodoItem, conn.params["id"])
      |> Repo.preload([todo_list: :project])

    conn = assign(conn, :todo_item, todo_item)
    conn = assign(conn, :todo_list, todo_item.todo_list)
    assign(conn, :project, todo_item.todo_list.project)
  end
end
