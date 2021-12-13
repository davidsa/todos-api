defmodule TodosApiWeb.Plugs.RequireAuth do
  use TodosApiWeb, :controller
  import Plug.Conn


  def init(_params) do 
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Unauthorized Error"})
      |> halt()
    end
  end
end
