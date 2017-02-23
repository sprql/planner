defmodule Planner.TagHelpers do
  @moduledoc """
  Planner tag helpers
  """

  use Phoenix.HTML

  @doc """
  Helper for list data
  """
  def list_as_string(list) do
    Enum.join(list, ", ")
  end
end
