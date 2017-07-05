class Hashtag < ApplicationRecord
  has_many :hashtag_trackers
  validates :name, presence: true, uniqueness: true
end
