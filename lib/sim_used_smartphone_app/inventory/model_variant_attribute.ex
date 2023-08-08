defmodule SimUsedSmartphoneApp.Inventory.ModelVariantAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  alias SimUsedSmartphoneApp.Inventory.{ModelVariant, Attribute}

  schema "model_variants_attributes" do
    belongs_to(:model_variant, ModelVariant)
    belongs_to(:attribute, Attribute)
    timestamps()
  end

  def changeset(%__MODULE__{} = model_variant_attribute, attrs) do
    model_variant_attribute
    |> cast(attrs, [:model_variant_id, :attribute_id])
    |> validate_required([:model_variant_id, :attribute_id])
    |> unique_constraint([:model_variant_id, :attribute_id])
  end
end
