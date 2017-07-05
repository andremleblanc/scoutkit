class TrackersController < ApplicationController
  skip_after_action :verify_authorized, only: [:show, :new, :create]

  def index
    @trackers = policy_scope(HashtagTracker)
  end

  def new
  end

  def create
    result = CreateHashtagTracker.call(merged_params)
    tracker = result.tracker

    if result.success?
      flash[:success] = I18n.t('trackers.create.success', name: tracker.name)
      redirect_to hashtag_tracker_path(result.tracker)
    else
      flash[:alert] = result.message
      redirect_to new_tracker_path
    end
  end

  private

  def merged_params
    tracker_params.merge(user: current_user)
  end

  def tracker_params
    params.require(:tracker).permit(:name)
  end
end
