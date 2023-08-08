defmodule SimUsedSmartphoneApp.Inventory.ModelService do
  alias SimUsedSmartphoneApp.Repo
  alias SimUsedSmartphoneApp.Inventory.Model

  @spec get_or_create_model(map()) ::
          {:ok, Model.t()} | {:error, :not_found} | {:error, Ecto.Changeset.t()}
  def get_or_create_model(%{"id" => id} = _params) do
    if model = Model |> Repo.get(id) do
      {:ok, model}
    else
      {:error, :not_found}
    end
  end

  def get_or_create_model(params) do
    %Model{} |> Model.changeset(params) |> Repo.insert()
  end
end
