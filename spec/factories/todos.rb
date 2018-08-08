FactoryBot.define do
  factory :todo do
    title { Faker::Job.title }
    created_by { Faker::Number.number(10) }
  end
end
