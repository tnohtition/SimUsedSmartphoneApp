defmodule SimUsedSmartphoneApp.Repo.Migrations.CreateModelVariantsAttributes do
  use Ecto.Migration

  def change do
    create table(:model_variants_attributes) do
      add :model_variant_id, references("model_variants"), null: false
      add :attribute_id, references("attributes"), null: false

      timestamps()
    end

    create index(:model_variants_attributes, :model_variant_id)
    create index(:model_variants_attributes, :attribute_id)
    create unique_index(:model_variants_attributes, [:model_variant_id, :attribute_id])
  end
end
