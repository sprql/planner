defmodule Planner.InputHelpers do
  @moduledoc """
  Planner input helpers
  """

  use Phoenix.HTML

  @doc """
  Input for list.
  """
  def array_input(form, field, opts \\ []) do
    values = case Phoenix.HTML.Form.input_value(form, field) do
               val when is_list(val) -> Enum.join(val, ", ")
               val -> val
             end

    opts =
      opts
      |> Keyword.put_new(:type, :text)
      |> Keyword.put_new(:id, input_id(form, field))
      |> Keyword.put_new(:name, input_name(form, field))
      |> Keyword.put_new(:value, values)
    tag(:input, opts)
  end
end
