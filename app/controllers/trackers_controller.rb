class TrackersController < ApplicationController
  skip_after_action :verify_authorized, only: [:new]
  skip_after_action :verify_policy_scoped, only: :index

  def index
    account_trackers = AccountTrackerDecorator.wrap(current_user.account_trackers)
    hashtag_trackers = HashtagTrackerDecorator.wrap(current_user.hashtag_trackers)
    @trackers = account_trackers + hashtag_trackers
  end

  def new
  end
end
