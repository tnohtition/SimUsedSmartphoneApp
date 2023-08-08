defmodule SimUsedSmartphoneApp.Inventory.ModelVariantService do
  alias SimUsedSmartphoneApp.Repo
  alias SimUsedSmartphoneApp.Inventory.ModelVariant

  @spec create(map()) ::
          {:ok, ModelVariant.t()} | {:error, Ecto.Changeset.t()}
  def create(params) do
    %ModelVariant{} |> ModelVariant.changeset(params) |> Repo.insert()
  end
end
