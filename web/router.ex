defmodule Story.Router do
  use Story.Web, :router

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

  scope "/api", Story do
    pipe_through :api
    # Route stuff to our SessionController
    resources "session", SessionController, only: [:index]
  end

  scope "/", Story do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/leaves", LeafController
    resources "/texts", SMSController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Story do
  #   pipe_through :api
  # end
end
