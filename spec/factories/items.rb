FactoryBot.define do
  factory :item do
    name { Faker::FunnyName.name }
    completed false
    todo_id nil
  end
end
