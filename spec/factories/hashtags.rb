FactoryGirl.define do
  factory :hashtag do
    sequence(:name) { Faker::Lorem.word }
  end
end
