defmodule Story.SMSControllerTest do
  use Story.ConnCase

  alias Story.SMS
  @valid_attrs %{content: "some content", sender: "some content", sent_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sms_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing texts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, sms_path(conn, :new)
    assert html_response(conn, 200) =~ "New sms"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, sms_path(conn, :create), sms: @valid_attrs
    assert redirected_to(conn) == sms_path(conn, :index)
    assert Repo.get_by(SMS, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sms_path(conn, :create), sms: @invalid_attrs
    assert html_response(conn, 200) =~ "New sms"
  end

  test "shows chosen resource", %{conn: conn} do
    sms = Repo.insert! %SMS{}
    conn = get conn, sms_path(conn, :show, sms)
    assert html_response(conn, 200) =~ "Show sms"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, sms_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    sms = Repo.insert! %SMS{}
    conn = get conn, sms_path(conn, :edit, sms)
    assert html_response(conn, 200) =~ "Edit sms"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    sms = Repo.insert! %SMS{}
    conn = put conn, sms_path(conn, :update, sms), sms: @valid_attrs
    assert redirected_to(conn) == sms_path(conn, :show, sms)
    assert Repo.get_by(SMS, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sms = Repo.insert! %SMS{}
    conn = put conn, sms_path(conn, :update, sms), sms: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit sms"
  end

  test "deletes chosen resource", %{conn: conn} do
    sms = Repo.insert! %SMS{}
    conn = delete conn, sms_path(conn, :delete, sms)
    assert redirected_to(conn) == sms_path(conn, :index)
    refute Repo.get(SMS, sms.id)
  end
end
