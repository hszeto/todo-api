class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at

  has_many :items

  def items
    object.items.order(:created_at).reverse
  end
end
