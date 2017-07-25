defmodule EpjsApp.PageController do
  use EpjsApp.Web, :controller

  def index(conn, _params) do
    json conn, []
  end
end
