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

    json_response({}, :accepted)
  end

  def destroy
    @item.destroy

    json_response({}, :accepted)
  end

  private

  def item_params
    params.permit(:name, :completed)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find(params[:id]) if @todo
  end
end
