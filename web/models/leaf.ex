defmodule Story.Leaf do
  use Story.Web, :model

  schema "leaves" do
    field :section, :string
    field :title, :string
    field :description, :string
    field :side_a, :string
    field :side_b, :string

    timestamps
  end

  @required_fields ~w(section title description side_a side_b)
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

  defmodule Queries do
    import Ecto.Query
    
    def random do
      query = from l in Story.Leaf,
        select: l.id,
        order_by: [desc: :id],
        limit: 1
      [max_id] = Story.Repo.all(query)
      IO.inspect(max_id)
      id = :random.uniform(max_id)
    end
  end
end
