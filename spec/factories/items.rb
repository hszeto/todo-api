FactoryBot.define do
  factory :item do
    name { Faker::FunnyName }
    done false
    todo_id nil
  end
end
