defmodule SimUsedSmartphoneApp.Inventory.ManufacturerService do
  alias SimUsedSmartphoneApp.Repo
  alias SimUsedSmartphoneApp.Inventory.Manufacturer

  @spec get_or_create_manufacturers(map()) ::
          {:ok, Manufacturer.t()} | {:error, :not_found} | {:error, Ecto.Changeset.t()}
  def get_or_create_manufacturers(%{"id" => id} = params) do
    if manufactor = Manufacturer |> Repo.get(id) do
      {:ok, manufactor}
    else
      {:error, :not_found}
    end
  end

  def get_or_create_manufacturers(params) do
    params |> Manufacturer.changeset() |> Repo.insert()
  end
end
