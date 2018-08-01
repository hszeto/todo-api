FactoryBot.define do
  factory :todo do
    title { Faker::FamousLastWords.last_words }
    created_by { Faker::Number.number(10) }
  end
end
