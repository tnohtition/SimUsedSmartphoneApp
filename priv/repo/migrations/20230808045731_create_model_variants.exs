defmodule SimUsedSmartphoneApp.Repo.Migrations.CreateModelVariants do
  use Ecto.Migration

  def change do
    create table(:model_variants) do
      add :sku, :string, null: false
      add :price, :decimal, null: false
      add :stock_quantity, :integer, null: false
      add :model_id, references("models")
      timestamps()
    end

    create unique_index(:model_variants, ["(lower(sku))"], name: :model_variants_lower_sku_index)
    create index(:model_variants, :model_id)
  end
end
