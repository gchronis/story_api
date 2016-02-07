defmodule Story.LeafTest do
  use Story.ModelCase

  alias Story.Leaf

  @valid_attrs %{description: "some content", section: "some content", side_a: "some content", side_b: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Leaf.changeset(%Leaf{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Leaf.changeset(%Leaf{}, @invalid_attrs)
    refute changeset.valid?
  end
end
