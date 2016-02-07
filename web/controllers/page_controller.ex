defmodule Story.PageController do
  use Story.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
