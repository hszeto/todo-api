class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    json_response( Todo.all )
  end

  def show
    json_response(@todo)
  end

  def create
    todo = Todo.create!(todo_params)
    json_response(todo, :created)
  end

  def update
    @todo.update(todo_params)
    json_response({}, :accepted)
  end

  def destroy
    @todo.destroy
    json_response({}, :accepted)
  end

  private

  def todo_params
    params.permit(:title, :created_by)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
