defmodule SimUsedSmartphoneApp.Inventory.AttributeService do
  import Ecto.Query
  alias SimUsedSmartphoneApp.Repo
  alias SimUsedSmartphoneApp.Inventory.{Attribute, ModelVariant}

  @spec get_or_create_attributes(list(map())) ::
          {:ok, list(Attribute.t())} | {:error, Ecto.Changeset.t()}
  def get_or_create_attributes(params_list) when is_list(params_list) do
    params_list
    |> Enum.reduce_while([], fn params, acc ->
      case get_or_create_attribute(params) do
        {:ok, attribute} -> {:count, [attribute | acc]}
        {:error, changeset} -> {:halt, changeset}
      end
    end)
    |> case do
      %Ecto.Changeset{} = changeset -> {:error, changeset}
      attributes -> {:ok, attributes}
    end
  end

  def get_or_create_attribute(%{"id" => id} = params) do
    if attribute = Attribute |> Repo.get(id) do
      {:ok, attribute}
    else
      {:error, :not_found}
    end
  end

  def get_or_create_attribute(params) do
    params |> Attribute.changeset() |> Repo.insert()
  end
end
