FactoryGirl.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    password 'abcd1234'

    after(:create) do |user, evaluator|
      create(:access_token, user: user)
    end
  end
end
