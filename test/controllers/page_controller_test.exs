defmodule Story.PageControllerTest do
  use Story.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "access point"
  end
end
