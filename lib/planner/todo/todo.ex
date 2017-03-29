defmodule Planner.Todo do
  @moduledoc """
  The boundary for the Todo system.
  """

  import Ecto.{Query, Changeset}, warn: false

  alias Planner.Repo
  alias Planner.Todo.{Project, List, Item}

  @recent_item_count 10

  def recent_todo_items do
    query = from ti in Item,
            where: ti.state == ^:todo,
            order_by: [desc: ti.inserted_at],
            limit: @recent_item_count
    Repo.all(query)
  end

  def list_todo_items do
    query = from ti in Item,
            where: ti.state == ^:todo,
            order_by: [desc: ti.inserted_at]
    Repo.all(query)
  end

  def list_completed_todo_items do
    query = from ti in Item,
            where: ti.state == ^:done,
            order_by: [desc: ti.updated_at]
    Repo.all(query)
  end

  def get_todo_item!(id) do
    Item
    |> Repo.get!(id)
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

  defp item_changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:content, :tags, :state, :done, :position])
    |> set_todo_item_state
    |> validate_required([:content])
  end

  defp set_todo_item_state(changeset) do
    case get_change(changeset, :done) do
      false -> change(changeset, state: :todo)
      true -> change(changeset, state: :done)
      nil -> changeset
    end
  end
end
