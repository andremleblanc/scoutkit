class HashtagTracker < ApplicationRecord
  belongs_to :hashtag
  belongs_to :user
  validates :hashtag, uniqueness: { scope: :user }

  class << self
    def find_by_param(name)
      HashtagTracker.joins(:hashtag).where(hashtags: { name: name }).first
    end
  end

  def access_token
    user.access_token.value
  end

  def name
    hashtag.name
  end

  def to_param
    name
  end

  def type
    :hashtag
  end
end
