RSpec.shared_examples "authenticated index" do
  describe 'GET #index' do
    let(:act) { get :index }

    describe 'when unauthenticated' do
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

RSpec.shared_examples "authenticated new" do
  describe 'GET #new' do
    let(:act) { get :new }

    describe 'unauthenticated' do
      it 'redirects to login page' do
        act
        expect(response).to redirect_to(new_user_session_path)
      end

      describe 'authenticated' do
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
end
