require 'rails_helper'
require 'support/shared_examples/controllers'

RSpec.describe AccountTrackersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    let(:account_tracker) { create(:account_tracker) }
    let(:act) { get :show, params: { id: account_tracker } }

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

      context 'and authorized' do
        let(:account_tracker) { create(:account_tracker, user: user) }

        it 'is successful' do
          act
          expect(response).to have_http_status(:success)
        end
      end

      context 'and unauthorized' do
        it 'raises an error' do
          expect{ act }.to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end

  describe 'POST #create' do
    let(:params) {{ tracker: { account: 'charity.grace' }}}
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
        VCR.use_cassette('controllers/account_trackers/success') do
          act
          expect(response).to have_http_status(302)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:account_tracker) { create(:account_tracker) }
    let(:act) { delete :destroy, params: { id: account_tracker } }

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

      context 'and authorized' do
        let(:account_tracker) { create(:account_tracker, user: user) }

        it 'is successful' do
          act
          expect(response).to redirect_to(trackers_path)
        end
      end

      context 'and unauthorized' do
        it 'raises an error' do
          expect{ act }.to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end
end
