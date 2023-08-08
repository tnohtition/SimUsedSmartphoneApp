defmodule SimUsedSmartphoneApp.Repo.Migrations.CreateAttributes do
  use Ecto.Migration

  def change do
    create table(:attributes) do
      add :name, :string, null: false
      add :value, :string
      timestamps()
    end

    create index(:attributes, :name)
  end
end
