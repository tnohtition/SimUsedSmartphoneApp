defmodule SimUsedSmartphoneApp.Inventory.Manufacturer do
  use Ecto.Schema
  import Ecto.Changeset
  alias SimUsedSmartphoneApp.Inventory.Model

  schema "manufacturers" do
    field(:name, :string)
    has_many(:models, Model)
    timestamps()
  end

  def changeset(%__MODULE__{} = manufacturer, attrs) do
    manufacturer
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name, name: :manufacturers_lower_name_index)
  end
end
