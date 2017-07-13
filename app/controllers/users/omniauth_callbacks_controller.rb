class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def instagram
    find_or_create_user
    sign_in_or_register
  end

  def failure
    redirect_to root_path
  end

  private

  def find_or_create_user
    if current_user.blank?
      @user = User.from_omniauth(request.env["omniauth.auth"])
    else
      @user = current_user
      User.set_instagram_attrs(@user, request.env['omniauth.auth'])
      @user.save!
      flash[:success] = I18n.t('omniauth.instagram.connected', account: @user.instagram_name)
    end
  end

  def sign_in_or_register
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = I18n.t('omniauth.instagram.create_account')
      session["devise.instagram_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
