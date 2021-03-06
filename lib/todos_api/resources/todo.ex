defmodule TodosApi.Resources.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :description, :string

    belongs_to :user, TodosApi.Account.User

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
