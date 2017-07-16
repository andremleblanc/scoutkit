class AccountTracker < ApplicationRecord
  belongs_to :account
  belongs_to :user
  validates :account, uniqueness: { scope: :user }
  alias_attribute :name, :account
  
  def access_token_value
    user.access_token.value
  end

  def name
    account.name
  end
end
