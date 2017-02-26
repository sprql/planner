defmodule Planner.TodoItemControllerTest do
  use Planner.ConnCase

  alias Planner.TodoItem
  @valid_attrs %{content: "some content", position: 42, state: "some state"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, todo_item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing todo item"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, todo_item_path(conn, :new)
    assert html_response(conn, 200) =~ "New todo item"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, todo_item_path(conn, :create), todo_item: @valid_attrs
    assert redirected_to(conn) == todo_item_path(conn, :index)
    assert Repo.get_by(TodoItem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, todo_item_path(conn, :create), todo_item: @invalid_attrs
    assert html_response(conn, 200) =~ "New todo item"
  end

  test "shows chosen resource", %{conn: conn} do
    todo_item = Repo.insert! %TodoItem{}
    conn = get conn, todo_item_path(conn, :show, todo_item)
    assert html_response(conn, 200) =~ "Show todo item"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, todo_item_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    todo_item = Repo.insert! %TodoItem{}
    conn = get conn, todo_item_path(conn, :edit, todo_item)
    assert html_response(conn, 200) =~ "Edit todo item"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    todo_item = Repo.insert! %TodoItem{}
    conn = put conn, todo_item_path(conn, :update, todo_item), todo_item: @valid_attrs
    assert redirected_to(conn) == todo_item_path(conn, :show, todo_item)
    assert Repo.get_by(TodoItem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    todo_item = Repo.insert! %TodoItem{}
    conn = put conn, todo_item_path(conn, :update, todo_item), todo_item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit todo item"
  end

  test "deletes chosen resource", %{conn: conn} do
    todo_item = Repo.insert! %TodoItem{}
    conn = delete conn, todo_item_path(conn, :delete, todo_item)
    assert redirected_to(conn) == todo_item_path(conn, :index)
    refute Repo.get(TodoItem, todo_item.id)
  end
end
