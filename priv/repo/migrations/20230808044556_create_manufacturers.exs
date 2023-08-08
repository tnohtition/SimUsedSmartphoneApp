defmodule SimUsedSmartphoneApp.Repo.Migrations.CreateManufacturers do
  use Ecto.Migration

  def change do
    create table(:manufacturers) do
      add :name, :string, null: false
      timestamps()
    end

    create unique_index(:manufacturers, ["(lower(name))"], name: :manufacturers_lower_name_index)
  end
end
