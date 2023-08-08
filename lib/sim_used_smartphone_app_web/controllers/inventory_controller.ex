defmodule SimUsedSmartphoneAppWeb.InventoryController do
  use SimUsedSmartphoneAppWeb, :controller
  alias SimUsedSmartphoneApp.Inventory

  # action_fallback SimUsedSmartphoneAppWeb.ActionFallback

  def create(conn, params) do
    user = conn.assigns.current_user

    with {:ok, model_variant} <- Inventory.register(user, params) do
      render(conn, "create.json", model_variant: Inventory.get_model_variant(model_variant.id))
    end
  end
end
