defmodule UiWeb.StatusView do
  use UiWeb, :view

  def render("show.json", _) do
    %{
      status: true,
      time: DateTime.utc_now()
    }
  end

end
