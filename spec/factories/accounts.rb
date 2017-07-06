FactoryGirl.define do
  factory :account do
    sequence(:instagram_uid) { Faker::Number.number(10) }
    sequence(:name) { Faker::StarWars.character }
  end
end
