defmodule SimUsedSmartphoneApp.Inventory.Model do
  use Ecto.Schema
  import Ecto.Changeset

  alias SimUsedSmartphoneApp.Inventory.Manufacturer

  schema "models" do
    field(:name, :string)
    belongs_to(:manufacturer, Manufacturer)
    timestamps()
  end

  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, [:name, :manufacturer_id])
    |> validate_required([:name, :manufacturer_id])
    |> unique_constraint(:name, name: :models_lower_name_index)
  end
end
