require 'rails_helper'

RSpec.describe HashtagTrackerPolicy do
  subject { described_class }

  describe HashtagTrackerPolicy::Scope do
    describe '#resolve' do
      let(:user) { create(:user) }
      let(:matching_tracker) { create(:hashtag_tracker, user: user) }
      let(:result) { subject.new(user, HashtagTracker).resolve }

      before do
        create(:hashtag_tracker)
      end

      it "filters to user's trackers" do
        expect(result).to eq [ matching_tracker ]
      end
    end
  end
end
