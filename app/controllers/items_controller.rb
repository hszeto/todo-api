class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_todo_item, only: [:show, :update, :destroy]

  def index
    json_response(@todo.items)
  end

  def show
    json_response(@item)
  end

  def create
    @todo.items.create!(item_params)

    json_response(@todo, :created)
  end

  def update
    @item.update!(item_params)

    json_response( @current_user.todos )
  end

  def destroy
    @item.destroy

    json_response({}, :accepted)
  end

  private

  def item_params
    params.permit(:name, :todo_id, :id, :completed )
  end

  def set_todo
    @todo = @current_user.todos.find(item_params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find(item_params[:id]) if @todo
  end
end
