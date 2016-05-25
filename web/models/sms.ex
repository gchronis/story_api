defmodule Story.SMS do
  use Story.Web, :model

  schema "texts" do
    field :sender, :string
    field :sent_at, Ecto.DateTime
    field :content, :binary

    timestamps
  end

  @required_fields ~w(sender sent_at content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
