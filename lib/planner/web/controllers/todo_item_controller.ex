defmodule Planner.Web.TodoItemController do
  use Planner.Web, :controller

  alias Planner.Todo
  alias Planner.Todo.{List, Item}

  plug :assign_current_todo_list when action in [:index, :new, :create]
  plug :assign_current_todo_item when action in [:show, :edit, :update, :delete]

  def index(conn, _params) do
    todo_items = Todo.todo_list_items(conn.assign.todo_list)
    render(conn, "index.html", todo_items: todo_items)
  end

  def new(conn, _params) do
    changeset = Todo.todo_list_change_item(conn.assigns.todo_list)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => todo_item_params}) do
    case Todo.create_todo_item(todo_item_params) do
      {:ok, todo_item} ->
        conn
        |> put_flash(:info, "Todo item created successfully.")
        |> redirect(to: todo_item_path(conn, :show, todo_item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _) do
    render(conn, "show.html")
  end

  def edit(conn, %{"id" => id}) do
    todo_item = Repo.get!(Item, id)
    changeset = Item.changeset(todo_item)
    render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo_item" => todo_item_params}) do
    todo_item = Repo.get!(Item, id)
    changeset = Item.changeset(todo_item, todo_item_params)

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
    todo_item = Repo.get!(Item, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(todo_item)

    conn
    |> put_flash(:info, "Todo item deleted successfully.")
    |> redirect(to: todo_list_path(conn, :show, todo_item.todo_list_id))
  end

  defp assign_current_todo_list(conn, _) do
    todo_list = Todo.get_todo_list!(conn.params["todo_list_id"])

    conn
    |> assign(:todo_list, todo_list)
    |> assign(:project, todo_list.project)
  end

  defp assign_current_todo_item(conn, _) do
    todo_item = Todo.get_todo_item!(conn.params["id"])

    conn
    |> assign(:todo_item, todo_item)
    |> assign(:todo_list, todo_item.todo_list)
    |> assign(:project, todo_item.todo_list.project)
  end
end
