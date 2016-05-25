defmodule Story.Repo.Migrations.CreateSMS do
  use Ecto.Migration

  def change do
    create table(:texts) do
      add :sender, :string
      add :sent_at, :datetime
      add :content, :text

      timestamps
    end

  end
end
