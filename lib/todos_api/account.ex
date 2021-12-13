defmodule TodosApi.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias TodosApi.Repo

  alias TodosApi.Account.User

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def validate_user(email, password) do
    with {:ok, user} <- get_by_email(email),
         true <- Bcrypt.verify_pass(password, user.password) do
      {:ok, user}
    end
  end


  def get_by_id(user_id) do
    Repo.get(User, user_id)
  end

  defp get_by_email(email) do
    query = from u in User, where: u.email == ^email 

    case Repo.one(query)do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end


end
