class User < ApplicationRecord
  has_many :todos, foreign_key: :created_by

  validates_presence_of :email, :name, :uuid
end
