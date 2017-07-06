class Account < ApplicationRecord
  has_many :account_trackers
  validates :instagram_uid, presence: true, uniqueness: true
  validates :name, presence: true
end
