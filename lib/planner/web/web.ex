defmodule Planner.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Planner.Web, :controller
      use Planner.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: Planner.Web
      import Plug.Conn
      import Planner.Web.Router.Helpers
      import Planner.Web.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/planner/web/templates",
                        namespace: Planner.Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Planner.Web.Router.Helpers
      import Planner.Web.ErrorHelpers
      import Planner.Web.Gettext
      import Planner.Web.TagHelpers
      import Planner.Web.InputHelpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import Planner.Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end