FactoryGirl.define do
  factory :access_token do
    user
    value Rails.application.secrets.dig :test, :instagram, :access_token
  end
end
