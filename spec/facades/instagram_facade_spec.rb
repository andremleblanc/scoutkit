require 'rails_helper'

RSpec.describe InstagramFacade, type: :facade do
  describe 'class methods' do
    subject { described_class }

    describe '#media_with_hashtag' do
      let(:result) { subject.media_with_hashtag('mermaid', access_token ) }
      let(:access_token) { Rails.application.secrets.dig :test, :instagram, :access_token }

      it 'returns a list of recently tagged media' do
        VCR.use_cassette('facades/instagram_facade/media_with_hashtag') do
          expect(result['data'].size).to eq 2
        end
      end
    end

    describe '#user' do
      let(:result) { subject.user('244841837', access_token ) }
      let(:access_token) { Rails.application.secrets.dig :test, :instagram, :access_token }

      it 'returns a list of recently tagged media' do
        VCR.use_cassette('facades/instagram_facade/user') do
          expect(result.dig 'data', 'username').to eq 'charity.grace'
        end
      end
    end
  end
end
