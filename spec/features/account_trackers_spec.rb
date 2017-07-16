require 'rails_helper'

RSpec.feature "AccountTrackers", type: :feature do
  let(:name) { 'charity.grace' }
  let(:account) { create(:account, name: name, instagram_uid: '244841837') }
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  it "creates, reads, and deletes", js: true do
    VCR.use_cassette('features/account_trackers/crud') do
      visit(trackers_path)
      expect(page).to have_current_path(trackers_path)

      click_on('Add')
      expect(page).to have_current_path(new_tracker_path)

      select('Account', from: 'type')
      fill_in 'Name', with: name
      click_on I18n.t('trackers.new.create').titleize
      expect(page).to have_current_path(account_tracker_path(AccountTracker.first))
      expect(page).to have_content(I18n.t('trackers.create.success', name: name))

      click_on I18n.t('nav.dashboard').titleize
      expect(page).to have_current_path(root_path)

      accept_alert { click_on I18n.t('trackers.tracker.delete').titleize }
      expect(page).to have_current_path(trackers_path)
      expect(page).to have_content(I18n.t('trackers.destroy.success', name: name))
      expect(AccountTracker.find_by(account: name)).not_to be
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
      let(:account_tracker) { create(:account_tracker, user: user, account: account) }

      it 'redirects to create and renders error message', js: true do
        VCR.use_cassette('features/account_trackers/duplicates') do
          visit(new_tracker_path)
          expect(page).to have_current_path(new_tracker_path)

          select('Account', from: 'type')
          fill_in 'Name', with: account_tracker.name
          click_on I18n.t('trackers.new.create').titleize
          expect(page).to have_current_path(new_tracker_path)
          expect(page).to have_content(I18n.t('account_tracker.validations.account.duplicate', account: account_tracker.name))
        end
      end
    end
  end

  context 'delete page option' do
    let!(:account_tracker) { create(:account_tracker, user: user, account: account) }

    it 'deletes account tracker' do
      VCR.use_cassette('features/account_trackers/delete') do
        visit(account_tracker_path(account_tracker))
        expect(page).to have_current_path(account_tracker_path(account_tracker))
        expect(AccountTracker.count).to be 1

        click_on 'page-options'
        click_on I18n.t('page_options.delete').titleize
        expect(page).to have_current_path(trackers_path)
        expect(page).to have_content(I18n.t('trackers.destroy.success', name: name))
        expect(AccountTracker.count).to be 0
      end
    end
  end
end
