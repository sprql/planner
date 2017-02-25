defmodule Planner.Router do
  use Planner.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Planner do
    pipe_through :browser # Use the default browser stack

    get "/", ProjectController, :index

    resources "/projects", ProjectController do
      resources "/todo-lists", TodoListController, only: [:index, :new, :create]
    end

    resources "/todo-lists", TodoListController, only: [:show, :edit, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Planner do
  #   pipe_through :api
  # end
end
