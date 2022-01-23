FactoryBot.define do
  factory :item do
    name { "Item: #{Faker::Business}" }
    completed { false }
    todo
  end
end
