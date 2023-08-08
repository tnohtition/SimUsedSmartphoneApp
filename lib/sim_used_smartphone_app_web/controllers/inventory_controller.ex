defmodule SimUsedSmartphoneAppWeb.InventoryController do
  use SimUsedSmartphoneAppWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias SimUsedSmartphoneApp.Inventory
  alias SimUsedSmartphoneAppWeb.Schemas.{InventoryRequest, InventoryResponse}

  action_fallback SimUsedSmartphoneAppWeb.FallbackController

  tags(["inventory"])

  operation(:create,
    summary: "Create product inventory",
    parameters: [],
    request_body: {"User params", "application/json", InventoryRequest},
    responses: [
      ok: {"Inventory response", "application/json", InventoryResponse}
    ]
  )

  def create(conn, params) do
    user = conn.assigns.current_user

    with {:ok, model_variant} <- Inventory.register(user, params) do
      render(conn, "create.json", model_variant: Inventory.get_model_variant(model_variant.id))
    end
  end
end
