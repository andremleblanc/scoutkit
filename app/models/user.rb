class User < ApplicationRecord
  has_one :access_token
  has_many :account_trackers
  has_many :hashtag_trackers
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: [ :instagram ]

  class << self
    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.instagram_data"]
          user.build_access_token(value: data.dig('credentials', 'token'))
          user.provider = 'instagram'
          user.uid = data['uid']
        end
      end
    end
  end

  def access_token_value
    access_token.value
  end

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create
  end
end
