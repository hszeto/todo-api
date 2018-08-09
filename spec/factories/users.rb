FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.name }
    email { Faker::Internet.safe_email }
    uuid { SecureRandom.uuid }
  end
end
