defmodule TodosApi.ResourcesTest do
  use TodosApi.DataCase

  alias TodosApi.Resources

  describe "todos" do
    alias TodosApi.Resources.Todo

    import TodosApi.ResourcesFixtures

    @invalid_attrs %{description: nil}

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Resources.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Resources.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      valid_attrs = %{description: "some description"}

      assert {:ok, %Todo{} = todo} = Resources.create_todo(valid_attrs)
      assert todo.description == "some description"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Todo{} = todo} = Resources.update_todo(todo, update_attrs)
      assert todo.description == "some updated description"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_todo(todo, @invalid_attrs)
      assert todo == Resources.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Resources.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Resources.change_todo(todo)
    end
  end
end
