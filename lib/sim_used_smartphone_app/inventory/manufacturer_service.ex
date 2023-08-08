defmodule SimUsedSmartphoneApp.Inventory.ManufacturerService do
  alias SimUsedSmartphoneApp.Repo
  alias SimUsedSmartphoneApp.Inventory.Manufacturer

  @spec get_or_create_manufacturer(map()) ::
          {:ok, Manufacturer.t()} | {:error, :not_found} | {:error, Ecto.Changeset.t()}
  def get_or_create_manufacturer(%{"id" => id} = _params) do
    if manufacturer = Manufacturer |> Repo.get(id) do
      {:ok, manufacturer}
    else
      {:error, :not_found}
    end
  end

  def get_or_create_manufacturer(params) do
    %Manufacturer{} |> Manufacturer.changeset(params) |> Repo.insert()
  end
end
