require 'rails_helper'

RSpec.describe AccountTracker, type: :model do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  describe 'validations' do
    subject { described_class }

    describe 'creating trackers for the same account' do
      describe 'rails' do
        before { create(:account_tracker, user: user, account: account) }

        context 'when the same user' do
          it { expect{ create(:account_tracker, user: user, account: account) }.to raise_error(ActiveRecord::RecordInvalid) }
        end

        context 'when different users' do
          it { expect{ create(:account_tracker, account: account) }.not_to raise_error }
        end
      end

      describe 'pg' do
        before { create(:account_tracker, user: user, account: account) }

        context 'when the same user' do
          let(:account_tracker) { subject.new(user: user, account: account) }
          it { expect{ account_tracker.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique) }
        end

        context 'when different users' do
          let(:account_tracker) { subject.new(user: create(:user), account: account) }
          it { expect{ account_tracker.save!(validate: false) }.not_to raise_error }
        end
      end
    end

    describe 'account' do
      describe 'rails' do
        it 'is required' do
          expect(build(:account_tracker, account: nil).valid?).to be false
        end
      end

      describe 'pg' do
        it 'is required' do
          account_tracker = subject.new(attributes_for(:account_tracker, account: nil))
          expect{ account_tracker.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end
      end
    end

    describe 'user' do
      describe 'rails' do
        it 'is required' do
          expect(build(:account_tracker, user: nil).valid?).to be false
        end
      end

      describe 'pg' do
        it 'is required' do
          account_tracker = subject.new(attributes_for(:account_tracker, user: nil))
          expect{ account_tracker.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end
      end
    end
  end
end
