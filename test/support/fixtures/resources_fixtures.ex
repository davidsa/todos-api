defmodule TodosApi.ResourcesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodosApi.Resources` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        description: "some description"
      })
      |> TodosApi.Resources.create_todo()

    todo
  end
end
