defmodule SimUsedSmartphoneApp.Repo.Migrations.CreateModels do
  use Ecto.Migration

  def change do
    create table(:models) do
      add :name, :string, null: false
      add :manufacturer_id, references("manufacturers")
      timestamps()
    end

    create unique_index(:models, ["(lower(name))"], name: :models_lower_name_index)
    create index(:models, :manufacturer_id)
  end
end
