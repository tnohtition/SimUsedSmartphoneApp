defmodule SimUsedSmartphoneApp.Inventory.ModelVariantAttributeService do
  alias SimUsedSmartphoneApp.Repo
  alias SimUsedSmartphoneApp.Inventory.{ModelVariantAttribute, ModelVariant, Attribute}
  alias Ecto.Changeset

  @spec create(ModelVariant.t(), list(Attribute.t()) | Attribute.t()) ::
          {:ok, ModelVariantAttribute.t()} | {:error, Ecto.Changeset.t()}
  def create(%ModelVariant{} = model_variant, attributes) when is_list(attributes) do
    attributes
    |> Enum.reduce_while([], fn attribute, acc ->
      case create(model_variant, attribute) do
        {:ok, model_variant_attribute} -> {:cont, [model_variant_attribute | acc]}
        {:error, changeset} -> {:halt, changeset}
      end
    end)
    |> case do
      %Ecto.Changeset{} = changeset -> {:error, changeset}
      attributes -> {:ok, attributes}
    end
  end

  def create(%ModelVariant{} = model_variant, %Attribute{} = attribute) do
    %{"model_variant_id" => model_variant.id, "attribute_id" => attribute.id}
    |> ModelVariantAttribute.changeset()
    |> Repo.insert()
  end
end
