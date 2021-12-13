defmodule TodosApiWeb.UserController do
  use TodosApiWeb, :controller

  alias TodosApi.Account
  plug TodosApiWeb.Plugs.RequireAuth when action in [:me]

  action_fallback TodosApiWeb.FallbackController

  def register(conn, %{"user" => user}) do
    with {:ok, user} <- Account.create_user(user) do
      conn
      |> put_status(:created)
      |> put_session(:user_id, user.id)
      |> render("show.json", user: user)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Account.validate_user(email,password) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> render("show.json", user: user)

      {:error, reason} ->
        IO.inspect(reason)
        conn
        |> json(%{error: "Something went wrong, please try again"})
    end
  end

  def me(conn, _params) do
    conn
    |> render("show.json", user: conn.assigns.user)
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> json(%{message: "Logout succesfull"})
  end

end
