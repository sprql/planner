defmodule Planner.Web.TodoItemController do
  use Planner.Web, :controller

  alias Planner.Todo
  alias Planner.Todo.Item

  def index(conn, _params) do
    todo_items = Todo.list_todo_items
    completed_todo_items = Todo.list_completed_todo_items
    render(conn, "index.html", todo_items: todo_items, completed_todo_items: completed_todo_items)
  end

  def new(conn, _params) do
    changeset = Todo.change_todo_item(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => todo_item_params}) do
    case Todo.create_todo_item(todo_item_params) do
      {:ok, todo_item} ->
        conn
        |> put_flash(:info, "Todo item created successfully.")
        |> redirect(to: todo_path(conn, :show))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _) do
    render(conn, "show.html")
  end

  def edit(conn, %{"id" => id}) do
    todo_item = Todo.get_todo_item!(id)
    changeset = Todo.change_todo_item(todo_item)
    render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => todo_item_params}) do
    todo_item = Todo.get_todo_item!(id)

    case Todo.update_todo_item(todo_item, todo_item_params) do
      {:ok, todo_item} ->
        conn
        |> put_flash(:info, "Todo item updated successfully.")
        |> redirect(to: todo_item_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_item = Todo.get_todo_item!(id)
    {:ok, _todo_item} = Todo.delete_todo_item(todo_item)

    conn
    |> put_flash(:info, "Todo item deleted successfully.")
    |> redirect(to: todo_item_path(conn, :index))
  end
end
