require 'rails_helper'

RSpec.describe HashtagTracker, type: :model do
  let(:user) { create(:user) }
  let(:hashtag) { create(:hashtag) }

  describe 'validations' do
    subject { described_class }

    describe 'creating trackers for the same tag' do
      describe 'rails' do
        before { create(:hashtag_tracker, user: user, hashtag: hashtag) }

        context 'when the same user' do
          it { expect{ create(:hashtag_tracker, user: user, hashtag: hashtag) }.to raise_error(ActiveRecord::RecordInvalid) }
        end

        context 'when different users' do
          it { expect{ create(:hashtag_tracker, hashtag: hashtag) }.not_to raise_error }
        end
      end

      describe 'pg' do
        before { HashtagTracker.create(user: user, hashtag: hashtag) }

        context 'when the same user' do
          let(:hashtag_tracker) { subject.new(user: user, hashtag: hashtag) }
          it { expect{ hashtag_tracker.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique) }
        end

        context 'when different users' do
          let(:hashtag_tracker) { subject.new(user: create(:user), hashtag: hashtag) }
          it { expect{ hashtag_tracker.save!(validate: false) }.not_to raise_error }
        end
      end
    end

    describe 'hashtag' do
      describe 'rails' do
        it 'is required' do
          expect(build(:hashtag_tracker, hashtag: nil).valid?).to be false
        end
      end

      describe 'pg' do
        it 'is required' do
          hashtag_tracker = subject.new(attributes_for(:hashtag_tracker, hashtag: nil))
          expect{ hashtag_tracker.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end
      end
    end

    describe 'user' do
      describe 'rails' do
        it 'is required' do
          expect(build(:hashtag_tracker, user: nil).valid?).to be false
        end
      end

      describe 'pg' do
        it 'is required' do
          hashtag_tracker = subject.new(attributes_for(:hashtag_tracker, user: nil))
          expect{ hashtag_tracker.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end
      end
    end
  end
end
