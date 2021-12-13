defmodule TodosApiWeb.UserView do
  use TodosApiWeb, :view
  alias TodosApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{user: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      lastname: user.lastname,
      email: user.email,
    }
  end
end
