defmodule SimUsedSmartphoneApp.Inventory do
  @moduledoc """
  The Inventory context.
  """

  alias Ecto.Multi
  alias SimUsedSmartphoneApp.Repo

  alias SimUsedSmartphoneApp.Accounts.User

  alias SimUsedSmartphoneApp.Inventory.{
    ManufacturerService,
    ModelService,
    ModelVariantService,
    AttributeService,
    ModelVariantAttributeService
  }

  @doc """
  Register a product (Model Variant) interface

  Example
      iex> SimUsedSmartphoneApp.register(%User{}, %{
        "manufacturer" => %{"id" => 1, "name" => "Apple"},
        "model" => %{"name" => "iPhone X"},
        "model_variant" => %{"sku" => "APPLE-201910-XYZ", "price" => "100.2", "stock_quantity" => 100},
        "attributes" => [
          %{"name" => "Body color", "value" => "Red", "id" => 1},
          %{"name" => "Data memory", "value" => "256G", "id" => 10},
          %{"name" => "Production year", "value" => "2010"},
          %{"name" => "OS Version", "value" => "iOS 14"}
        ]
      })
      {:ok, %ModelVariant{id: 123, sku: "APPLE-201910-XYZ", price: 100.2, stock_quantity: 100}}
  """
  @spec register(User.t(), map()) :: {:ok, ModelVariant.t()} | {:error, any()}
  def register(%User{} = _user, params) do
    Multi.new()
    |> Multi.run(:manufacturer, fn _repo, _ ->
      ManufacturerService.get_or_create_manufacturer(params["manufacturer"])
    end)
    |> Multi.run(:model, fn _repo, %{manufacturer: manufacturer} ->
      ModelService.get_or_create_model(
        params["model"]
        |> Map.put("manufacturer_id", manufacturer)
      )
    end)
    |> Multi.run(:model_variant, fn _repo, %{model: model} ->
      ModelVariantService.create(params["model_variant"] |> Map.put("model_id", model.id))
    end)
    |> Multi.run(:attributes, fn _repo, _ ->
      AttributeService.get_or_create_attributes(params["attributes"])
    end)
    |> Multi.run(:attributes, fn _repo, %{model_variant: model_variant, attributes: attributes} ->
      ModelVariantAttributeService.create(model_variant, attributes)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{model_variant: model_variant}} ->
        {:ok, model_variant}

      {:error, _failed_operation, failed_value, _changes_so_far} ->
        {:error, failed_value}
    end
  end

  @doc """
  Get model variant with preloaded data

  Example
      iex> SimUsedSmartphoneApp.get_model_variant(1)
      %ModelVariant{id: 123}
  """
  @spec get_model_variant(integer()) :: ModelVariant.t() | nil
  def get_model_variant(id) do
    ModelVariant |> Repo.get(id) |> Repo.preload(:attributes, model: :manufacturer)
  end
end
