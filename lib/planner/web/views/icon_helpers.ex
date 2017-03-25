defmodule Planner.Web.IconHelpers do
  @moduledoc """
  Creates a icon tag. Current implemetation for Font Awesome icons.
  """

  use Phoenix.HTML

  @doc """
  Icon tag helper
  """
  @spec icon_tag(String.t) :: {:safe, [String.t]}
  def icon_tag(name) do
    content_tag(:i, "", class: "fa fa-#{name}", "aria-hidden": "true")
  end
end
