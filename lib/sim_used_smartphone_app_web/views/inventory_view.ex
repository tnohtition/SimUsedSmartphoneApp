defmodule SimUsedSmartphoneAppWeb.InventoryView do
  use SimUsedSmartphoneAppWeb, :view

  def render("create.json", %{model_inventory: model_inventory}) do
    %{
      data: render_one(model_inventory, __MODULE__, "model_inventory.json", as: :model_inventory)
    }
  end

  def render("model_inventory.json", %{model_inventory: model_inventory}) do
    %{
      id: model_inventory.id,
      sku: model_inventory.sku,
      price: model_inventory.price,
      stock_quantity: model_inventory.stock_quantity,
      model: render_one(model_inventory.model, __MODULE__, "model.json", as: :model),
      attributes:
        render_many(model_inventory.attributes, __MODULE__, "attribute.json", as: :attribute)
    }
  end

  def render("model.json", %{model: model}) do
    %{
      id: model.id,
      name: model.name,
      manufacturer:
        render_one(model.manufacturer, __MODULE__, "manufacturer.json", as: :manufacturer)
    }
  end

  def render("manufacturer.json", %{manufacturer: manufacturer}) do
    %{
      id: manufacturer.id,
      name: manufacturer.name
    }
  end

  def render("attribute.json", %{attribute: attribute}) do
    %{
      id: attribute.id,
      name: attribute.name,
      value: attribute.value
    }
  end
end
