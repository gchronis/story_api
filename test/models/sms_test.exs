defmodule Story.SMSTest do
  use Story.ModelCase

  alias Story.SMS

  @valid_attrs %{content: "some content", sender: "some content", sent_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SMS.changeset(%SMS{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SMS.changeset(%SMS{}, @invalid_attrs)
    refute changeset.valid?
  end
end
