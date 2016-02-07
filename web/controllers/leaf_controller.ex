defmodule Story.LeafController do
  use Story.Web, :controller

  alias Story.Leaf

  plug :scrub_params, "leaf" when action in [:create, :update]

  def index(conn, _params) do
    leaves = Repo.all(Leaf)
    render(conn, "index.html", leaves: leaves)
  end

  def new(conn, _params) do
    changeset = Leaf.changeset(%Leaf{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"leaf" => leaf_params}) do
    changeset = Leaf.changeset(%Leaf{}, leaf_params)

    case Repo.insert(changeset) do
      {:ok, _leaf} ->
        conn
        |> put_flash(:info, "Leaf created successfully.")
        |> redirect(to: leaf_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    leaf = Repo.get!(Leaf, id)
    render(conn, "show.html", leaf: leaf, links: get_some_links)
  end

  def edit(conn, %{"id" => id}) do
    leaf = Repo.get!(Leaf, id)
    changeset = Leaf.changeset(leaf)
    render(conn, "edit.html", leaf: leaf, changeset: changeset)
  end

  def update(conn, %{"id" => id, "leaf" => leaf_params}) do
    leaf = Repo.get!(Leaf, id)
    changeset = Leaf.changeset(leaf, leaf_params)

    case Repo.update(changeset) do
      {:ok, leaf} ->
        conn
        |> put_flash(:info, "Leaf updated successfully.")
        |> redirect(to: leaf_path(conn, :show, leaf))
      {:error, changeset} ->
        render(conn, "edit.html", leaf: leaf, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    leaf = Repo.get!(Leaf, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(leaf)

    conn
    |> put_flash(:info, "Leaf deleted successfully.")
    |> redirect(to: leaf_path(conn, :index))
  end
  
  def get_some_links do
    %{:one =>  Leaf.Queries.random, :two => Leaf.Queries.random, :three => Leaf.Queries.random}
  end
end
