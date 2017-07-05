require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe 'validations' do
    subject { described_class }

    describe 'required' do
      it { expect(build(:access_token).valid?).to be true}

      describe 'by rails' do
        describe 'user' do
          it { expect(build(:access_token, user: nil).valid?).to be false }
        end

        describe 'value' do
          it { expect(build(:access_token, value: nil).valid?).to be false }
        end
      end

      describe 'by pg' do
        it 'throws error if user is missing' do
          token = subject.new(attributes_for(:access_token, user: nil))
          expect{ token.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end

        it 'throws error if value is missing' do
          token = subject.new(attributes_for(:access_token, value: nil))
          expect{ token.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end
      end
    end
  end
end
