defmodule SimUsedSmartphoneAppWeb.PageController do
  use SimUsedSmartphoneAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
