class User < ApplicationRecord
  has_one :access_token
  has_many :account_trackers
  has_many :hashtag_trackers
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :lockable,
         :omniauthable, omniauth_providers: [ :instagram ]

  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create
    end

    def new_with_session(params, session)
      super.tap do |user|
        data = session["devise.instagram_data"]
        set_instagram_attrs(user, data) if data
      end
    end

    def set_instagram_attrs(user, data)
      user.build_access_token(value: data.dig('credentials', 'token'))
      user.provider = 'instagram'
      user.uid = data['uid']
      user.instagram_name = data.dig 'info', 'nickname'
    end
  end

  def access_token_value
    access_token.value
  end
end
