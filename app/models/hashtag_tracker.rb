class HashtagTracker < ApplicationRecord
  belongs_to :hashtag
  belongs_to :user
  validates :hashtag, uniqueness: { scope: :user }

  # TODO: Should this belong to many users?
  def access_token_value
    user.access_token.value
  end

  def name
    hashtag.name
  end
end
