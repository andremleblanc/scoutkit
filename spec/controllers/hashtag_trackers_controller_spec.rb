require 'rails_helper'
require 'support/shared_examples/controllers'

RSpec.describe HashtagTrackersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    let(:hashtag_tracker) { create(:hashtag_tracker) }
    let(:act) { get :show, params: { id: hashtag_tracker, type: hashtag_tracker.type } }

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
        let(:hashtag_tracker) { create(:hashtag_tracker, user: user) }

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

  describe 'DELETE #destroy' do
    let(:hashtag_tracker) { create(:hashtag_tracker) }
    let(:act) { delete :destroy, params: { id: hashtag_tracker, type: hashtag_tracker.type } }

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
        let(:hashtag_tracker) { create(:hashtag_tracker, user: user) }

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
