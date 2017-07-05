require 'rails_helper'
require 'support/shared_examples/controllers'

RSpec.describe TrackersController, type: :controller do
  include_examples "authenticated index"
  include_examples "authenticated new"
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:hashtag_name) { Faker::Lorem.word }
    let(:params) {{ tracker: { name: hashtag_name }}}
    let(:act) { post :create, params: params }

    describe 'unauthenticated' do
      it 'redirects to login page' do
        act
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'authenticated' do
      before do
        sign_in user
      end

      it 'is successful' do
        act
        expect(response).to have_http_status(302)
      end
    end
  end
end
