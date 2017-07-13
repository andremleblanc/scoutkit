require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  let(:email) { Faker::Internet.email }
  let(:user) { User.find_by(email: email) }
  let(:access_token) { Faker::Number.number(10) }
  let(:uid) { Faker::Number.number(10) }
  let(:nickname) { 'charity.grace' }

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
      credentials: { token: access_token },
      info: { nickname: nickname },
      provider: 'instagram',
      uid: uid
    })
  end

  after do
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:instagram] = nil
  end

  describe 'creating an email/password account' do
    it 'creates account and connects Instagram' do
      visit(new_user_session_path)
      expect(page).to have_current_path(new_user_session_path)

      click_on 'Sign up'
      expect(page).to have_current_path(new_user_registration_path)

      fill_in 'Email', with: email
      fill_in 'Password', with: 'abcd1234'
      fill_in 'Password confirmation', with: 'abcd1234'
      click_button 'Sign up'
      expect(page).to have_current_path(new_access_token_path)

      click_on 'Connect Instagram Account'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content(I18n.t('omniauth.instagram.connected', account: nickname))

      # TODO: User can login with Instagram
    end
  end

  describe 'connecting Instagram and then setting up account' do
    it 'saves user and instagram uid and allows subsequent logins with Instagram' do
      visit(new_user_session_path)
      expect(page).to have_current_path(new_user_session_path)

      click_on 'Sign in with Instagram'
      expect(page).to have_current_path(new_user_registration_path)

      fill_in 'Email', with: email
      fill_in 'Password', with: 'abcd1234'
      fill_in 'Password confirmation', with: 'abcd1234'
      click_button 'Sign up'
      expect(page).to have_current_path(root_path)

      expect(user).to be
      expect(user.uid).to eq uid
      expect(user.access_token.value).to eq access_token

      click_button 'accbtn'
      click_on 'Log Out'
      expect(page).to have_current_path(new_user_session_path)

      click_on 'Sign in with Instagram'
      expect(page).to have_current_path(root_path)
    end
  end
end
