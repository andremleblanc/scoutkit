require 'rails_helper'

RSpec.feature "HastagTrackers", type: :feature do
  let(:hashtag) { create(:hashtag, name: name) }
  let(:name) { 'mermaid' }
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  context 'delete page option' do
    let!(:hashtag_tracker) { create(:hashtag_tracker, user: user, hashtag: hashtag) }

    it 'deletes hashtag tracker' do
      VCR.use_cassette('features/hashtag_trackers/delete') do
        visit(trackers_path)
        expect(page).to have_current_path(trackers_path)

        click_on I18n.t('trackers.tracker.show')
        expect(page).to have_current_path(hashtag_tracker_path(hashtag_tracker))
        expect(HashtagTracker.count).to be 1

        click_on 'page-options'
        click_on I18n.t('page_options.delete').titleize
        expect(page).to have_current_path(trackers_path)
        expect(page).to have_content(I18n.t('trackers.destroy.success', name: name))
        expect(HashtagTracker.count).to be 0
      end
    end
  end
end
