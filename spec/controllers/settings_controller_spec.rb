require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    let(:act) { get :show }

    describe 'unauthenticated' do
      it 'redirects to login page' do
        act
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when authenticated' do
      before do
        sign_in user
      end

      it 'is successful' do
        act
        expect(response).to have_http_status(:success)
      end
    end
  end
end
