class AccessTokensController < ApplicationController
  skip_before_action :validate_instagram_access_token
  skip_after_action :verify_authorized, only: :new

  def new
    redirect_to root_path if current_user.access_token.present?
  end
end
