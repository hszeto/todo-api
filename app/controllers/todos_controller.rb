class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    json_response( @current_user.todos )
  end

  def show
    json_response(@todo)
  end

  def create
    todo = @current_user.todos.create!(todo_params)

    json_response( @current_user.todos )
  end

  def update
    @todo.update(todo_params)

    json_response( @current_user.todos )
  end

  def destroy
    @todo.destroy

    json_response( @current_user.todos )
  end

  private

  def todo_params
    params.permit(:title, :created_by)
  end

  def set_todo
    @todo = @current_user.todos.find(params[:id])
  end
end
