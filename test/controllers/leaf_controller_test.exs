defmodule Story.LeafControllerTest do
  use Story.ConnCase

  alias Story.Leaf
  @valid_attrs %{description: "some content", section: "some content", side_a: "some content", side_b: "some content", title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, leaf_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing leaves"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, leaf_path(conn, :new)
    assert html_response(conn, 200) =~ "New leaf"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, leaf_path(conn, :create), leaf: @valid_attrs
    assert redirected_to(conn) == leaf_path(conn, :index)
    assert Repo.get_by(Leaf, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, leaf_path(conn, :create), leaf: @invalid_attrs
    assert html_response(conn, 200) =~ "New leaf"
  end

  test "shows chosen resource", %{conn: conn} do
    leaf = Repo.insert! %Leaf{}
    conn = get conn, leaf_path(conn, :show, leaf)
    assert html_response(conn, 200) =~ "Side A"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, leaf_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    leaf = Repo.insert! %Leaf{}
    conn = get conn, leaf_path(conn, :edit, leaf)
    assert html_response(conn, 200) =~ "Edit leaf"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    leaf = Repo.insert! %Leaf{}
    conn = put conn, leaf_path(conn, :update, leaf), leaf: @valid_attrs
    assert redirected_to(conn) == leaf_path(conn, :show, leaf)
    assert Repo.get_by(Leaf, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    leaf = Repo.insert! %Leaf{}
    conn = put conn, leaf_path(conn, :update, leaf), leaf: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit leaf"
  end

  test "deletes chosen resource", %{conn: conn} do
    leaf = Repo.insert! %Leaf{}
    conn = delete conn, leaf_path(conn, :delete, leaf)
    assert redirected_to(conn) == leaf_path(conn, :index)
    refute Repo.get(Leaf, leaf.id)
  end
end
