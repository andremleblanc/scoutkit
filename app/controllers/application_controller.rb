class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, if: :devise_controller?

  before_action :validate_instagram_access_token
  skip_before_action :validate_instagram_access_token, if: :devise_controller?

  def validate_instagram_access_token
    if current_user.access_token.blank?
      redirect_to new_access_token_path
    end
  end
end
