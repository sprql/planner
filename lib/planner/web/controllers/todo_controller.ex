defmodule Planner.Web.TodoController do
  use Planner.Web, :controller

  alias Planner.Todo

  def show(conn, _) do
    todo_items = Todo.recent_todo_items
    render(conn, "show.html", todo_items: todo_items)
  end
end
