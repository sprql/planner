defmodule Planner.InputHelpers do
  @moduledoc """
  Planner input helpers
  """

  use Phoenix.HTML

  @doc """
  Input for list.
  """
  def array_input(form, field, opts \\ []) do
    values = Phoenix.HTML.Form.input_value(form, field) |> Enum.join(", ")

    opts =
      opts
      |> Keyword.put_new(:type, :text)
      |> Keyword.put_new(:id, input_id(form, field))
      |> Keyword.put_new(:name, input_name(form, field))
      |> Keyword.put_new(:value, values)
    tag(:input, opts)
  end
end
