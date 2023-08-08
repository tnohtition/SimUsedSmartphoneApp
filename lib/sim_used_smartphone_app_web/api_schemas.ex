defmodule SimUsedSmartphoneAppWeb.ApiSchemas do
  alias OpenApiSpex.Schema

  defmodule InventoryRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Inventory Request",
      description: "Request schema for single inventory registration",
      type: :object,
      properties: %{
        data: %Schema{
          type: :object,
          properties: %{
            manufacturer: %Schema{
              type: :string,
              description: "Manufacturer",
              properties: %{
                id: %Schema{type: :integer, description: "Manufacturer ID"},
                name: %Schema{type: :string, description: "Manufacturer Name"}
              }
            },
            model_variant: %Schema{
              type: :object,
              description: "Model Variant",
              properties: %{
                sku: %Schema{type: :string, description: "Model Variant SKU", required: true},
                price: %Schema{type: :decimal, description: "Model Variant Price", required: true},
                stock_quantity: %Schema{
                  type: :integer,
                  description: "Model Variant Stock Quantity",
                  required: true
                }
              }
            },
            model: %Schema{
              type: :object,
              description: "Model",
              properties: %{
                id: %Schema{type: :integer, description: "Model ID"},
                name: %Schema{type: :string, description: "Model Name"}
              }
            },
            attributes: %Schema{
              type: :array,
              items: %Schema{
                type: :object,
                description: "An Attribute",
                properties: %{
                  id: %Schema{type: :integer, description: "Attribute ID"},
                  name: %Schema{type: :string, description: "Attribute Name"},
                  value: %Schema{type: :string, description: "Attribute Value"}
                }
              }
            }
          }
        }
      },
      example: %{
        "data" => %{
          "manufacturer" => %{
            "id" => 2,
            "name" => "Apple"
          },
          "model" => %{
            "id" => 1,
            "name" => "iPhone X"
          },
          "model_variant" => %{
            "sku" => "APPLE-2019-XYZ",
            "price" => 100.2,
            "stock_quantity" => 100
          },
          "attributes" => [
            %{"id" => 1, "name" => "Body Color", "value" => "Red"},
            %{"id" => 2, "name" => "Data memory", "value" => "128GB"},
            %{"name" => "Production year", "value" => "2019"}
          ]
        }
      }
    })
  end

  defmodule InventoryResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Inventory Response",
      description: "Response schema for single inventory registration",
      type: :object,
      properties: %{
        data: %Schema{
          type: :object,
          properties: %{
            id: %Schema{type: :integer, description: "Model Variant ID"},
            sku: %Schema{type: :string, description: "Model Variant SKU"},
            price: %Schema{type: :decimal, description: "Model Variant Price"},
            stock_quantity: %Schema{type: :integer, description: "Model Variant Stock Quantity"},
            model: %Schema{
              type: :object,
              description: "Model",
              properties: %{
                id: %Schema{type: :integer, description: "Model ID"},
                name: %Schema{type: :string, description: "Model Name"},
                manufacturer: %Schema{
                  type: :string,
                  description: "Manufacturer",
                  properties: %{
                    id: %Schema{type: :integer, description: "Manufacturer ID"},
                    name: %Schema{type: :string, description: "Manufacturer Name"}
                  }
                }
              }
            },
            attributes: %Schema{
              type: :array,
              items: %Schema{
                type: :object,
                description: "An Attribute",
                properties: %{
                  id: %Schema{type: :integer, description: "Attribute ID"},
                  name: %Schema{type: :string, description: "Attribute Name"},
                  value: %Schema{type: :string, description: "Attribute Value"}
                }
              }
            }
          }
        }
      },
      example: %{
        "data" => %{
          "id" => 123,
          "sku" => "APPLE-2019-XYZ",
          "price" => 100.2,
          "stock_quantity" => 100,
          "model" => %{
            "id" => 1,
            "name" => "iPhone X",
            "manufacturer" => %{
              "id" => 2,
              "name" => "Apple"
            }
          },
          "attributes" => [
            %{"id" => 1, "name" => "Body Color", "value" => "Red"},
            %{"id" => 2, "name" => "Data memory", "value" => "128GB"},
            %{"id" => 3, "name" => "Production year", "value" => "2019"}
          ]
        }
      }
    })
  end
end
