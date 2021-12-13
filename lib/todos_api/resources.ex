defmodule TodosApi.Resources do
  import Ecto.Query, warn: false
  alias TodosApi.Repo

  alias TodosApi.Resources.Todo

  def list_todos(user) do
    user
    |> Repo.preload(:todos)
    |> Map.get(:todos)
  end

  def get_todo(id), do: Repo.get(Todo, id)

  def create_todo(user, todo) do
    user
    |> Ecto.build_assoc(:todos)
    |> Todo.changeset(todo)
    |> Repo.insert()
  end

  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
  end

  def delete_todo(%Todo{} = todo) do
    Repo.delete(todo)
  end

  def change_todo(%Todo{} = todo, attrs \\ %{}) do
    Todo.changeset(todo, attrs)
  end
end
