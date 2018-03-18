defmodule UiWeb.StatusController do
  use UiWeb, :controller

  def show(conn, _params) do
    render conn, "show.json"
  end
end
