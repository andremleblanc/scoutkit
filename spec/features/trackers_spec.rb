require 'rails_helper'

RSpec.feature "Trackers", type: :feature do
  let(:name) { 'mermaid' }
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  it "CRUDs" do
    VCR.use_cassette('features/trackers/crud') do
      visit(trackers_path)
      expect(page).to have_current_path(trackers_path)

      click_on('Add')
      expect(page).to have_current_path(new_tracker_path)

      fill_in 'Name', with: name
      click_on I18n.t('trackers.new.create').titleize
      expect(page).to have_current_path(hashtag_tracker_path(HashtagTracker.first))
      expect(page).to have_content(I18n.t('trackers.create.success', name: name))

      click_on I18n.t('nav.trackers').titleize
      expect(page).to have_current_path(trackers_path)

      click_on I18n.t('trackers.tracker.delete').titleize
      expect(page).to have_current_path(trackers_path)
      expect(page).to have_content(I18n.t('trackers.destroy.success', name: name))
      expect(HashtagTracker.find_by(hashtag: Hashtag.find_by(name: name))).not_to be
    end
  end

  describe 'create' do
    context 'required' do
      it 'enforces required fields' do
        visit(new_tracker_path)
        click_on I18n.t('trackers.new.create').titleize
        expect(page).to have_current_path(new_tracker_path)
      end
    end

    context 'duplicates' do
      let!(:hashtag_tracker) { create(:hashtag_tracker, user: user) }

      it 'redirects to create and renders error message' do
        visit(new_tracker_path)
        expect(page).to have_current_path(new_tracker_path)

        fill_in 'Name', with: hashtag_tracker.name
        click_on I18n.t('trackers.new.create').titleize
        expect(page).to have_current_path(new_tracker_path)
        expect(page).to have_content(I18n.t('hashtag_tracker.validations.hashtag.duplicate', hashtag: hashtag_tracker.name))
      end
    end
  end
end
