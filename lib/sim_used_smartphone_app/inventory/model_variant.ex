defmodule SimUsedSmartphoneApp.Inventory.ModelVariant do
  use Ecto.Schema
  import Ecto.Changeset

  alias SimUsedSmartphoneApp.Inventory.Model

  schema "model_variants" do
    field(:sku, :string)
    field(:price, :decimal)
    field(:stock_quantity, :integer)

    belongs_to(:model, Model)
    timestamps()
  end

  def changeset(%__MODULE__{} = model_variant, attrs) do
    model_variant
    |> cast(attrs, [:sku, :price, :stock_quantity, :model_id])
    |> validate_required([:sku, :price, :stock_quantity, :model_id])
    |> validate_number(:price, greater_than_or_equal_to: 0)
    |> validate_number(:stock_quantity, greater_than_or_equal_to: 0)
    |> unique_constraint(:sku, name: :model_variants_lower_sku_index)
  end
end
