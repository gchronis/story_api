defmodule Story.Repo.Migrations.CreateLeaf do
  use Ecto.Migration

  def change do
    create table(:leaves) do
      add :section, :string
      add :title, :string
      add :description, :text
      add :side_a, :text
      add :side_b, :text

      timestamps
    end

  end
end
