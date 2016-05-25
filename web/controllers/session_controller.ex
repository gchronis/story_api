defmodule Story.SessionController do
  use Story.Web, :controller

  def index(conn, _params) do
    # Return some static JSON for now
    conn
    |> json(%{status: "CI with Travis"})
  end
end
