require 'rails_helper'

RSpec.feature "HashtagTrackers", type: :feature do
  let(:name) { 'mermaid' }
  let(:hashtag) { create(:hashtag, name: name) }
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  it "creates, reads, and deletes", js: true do
    VCR.use_cassette('features/hashtag_trackers/crud') do
      visit(trackers_path)
      expect(page).to have_current_path(trackers_path)

      click_on('Add')
      expect(page).to have_current_path(new_tracker_path)

      fill_in 'Name', with: name
      click_on I18n.t('trackers.new.create').titleize
      expect(page).to have_current_path(hashtag_tracker_path(HashtagTracker.first))
      expect(page).to have_content(I18n.t('trackers.create.success', name: name))

      click_on I18n.t('nav.dashboard').titleize
      expect(page).to have_current_path(root_path)

      accept_alert { click_on I18n.t('trackers.tracker.delete').titleize }
      expect(page).to have_current_path(trackers_path)
      expect(page).to have_content(I18n.t('trackers.destroy.success', name: name))
      expect(HashtagTracker.find_by(hashtag: Hashtag.find_by(name: name))).not_to be
    end
  end

  describe 'create' do
    context 'required' do
      it 'enforces required fields', js: true do
        visit(new_tracker_path)
        click_on I18n.t('trackers.new.create').titleize
        expect(page).to have_current_path(new_tracker_path)
      end
    end

    context 'duplicates' do
      let(:hashtag_tracker) { create(:hashtag_tracker, user: user) }

      it 'redirects to create and renders error message', js: true do
        visit(new_tracker_path)
        expect(page).to have_current_path(new_tracker_path)

        fill_in 'Name', with: hashtag_tracker.name
        click_on I18n.t('trackers.new.create').titleize
        expect(page).to have_current_path(new_tracker_path)
        expect(page).to have_content(I18n.t('hashtag_tracker.validations.hashtag.duplicate', hashtag: hashtag_tracker.name))
      end
    end
  end

  context 'delete page option' do
    let(:hashtag_tracker) { create(:hashtag_tracker, user: user, hashtag: hashtag) }

    it 'deletes hashtag tracker' do
      VCR.use_cassette('features/hashtag_trackers/delete') do
        visit(hashtag_tracker_path(hashtag_tracker))
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
