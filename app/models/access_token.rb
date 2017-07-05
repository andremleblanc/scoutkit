class AccessToken < ApplicationRecord
  belongs_to :user
  validates :value, presence: true
  attr_encryptor :value, key: Rails.application.secrets.access_token_key
end
