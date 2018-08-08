FactoryBot.define do
  factory :item do
    name { Faker::FamousLastWords.last_words }
    completed false
    todo_id nil
  end
end
