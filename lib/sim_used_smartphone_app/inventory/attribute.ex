defmodule SimUsedSmartphoneApp.Inventory.Attribute do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attributes" do
    field(:name, :string)
    field(:value, :string)
    timestamps()
  end

  def changeset(%__MODULE__{} = attribute, attrs) do
    attribute
    |> cast(attrs, [:name, :value])
    |> validate_required([:name])
  end
end
