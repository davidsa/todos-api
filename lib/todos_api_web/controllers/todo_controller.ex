defmodule TodosApiWeb.TodoController do
  use TodosApiWeb, :controller

  alias TodosApi.Resources
  alias TodosApi.Resources.Todo
  alias TodosApi.Repo

  plug TodosApiWeb.Plugs.RequireAuth
  plug :check_todo_owner when action in [:show, :update, :delete]

  action_fallback TodosApiWeb.FallbackController

  def index(conn, _params) do
    todos = Resources.list_todos(conn.assigns.user)
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- Resources.create_todo(conn.assigns.user, todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Resources.get_todo(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    with todo <- Resources.get_todo(id),
         {:ok, %Todo{} = todo} <- Resources.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do

    with todo <- Resources.get_todo(id),
         {:ok, %Todo{}} <- Resources.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end

  def check_todo_owner(conn, _params) do
    %{params: %{"id" => todo_id}} = conn

    case Repo.get(Todo, todo_id) do
      %Todo{user_id: user_id} -> 
        if user_id === conn.assigns.user.id do
          conn
        else
          conn
          |> put_status(:forbidden)
          |> json(%{error: "Todo doesn't belong to you"})
          |> halt()
        end
      nil ->
        conn
        |> put_status(:forbidden)
        |> json(%{error: "Todo doesn't exist"})
        |> halt()
    end
  end
end
