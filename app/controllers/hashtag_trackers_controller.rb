class HashtagTrackersController < ApplicationController
  def show
    tracker = HashtagTracker.find_by_param(params[:id])
    authorize tracker
    @presenter = HashtagTrackers::ShowPresenter.new(tracker)
  end

  def destroy
    tracker = HashtagTracker.find_by_param(params[:id])
    authorize tracker

    if tracker.destroy
      flash[:success] = I18n.t('trackers.destroy.success', name: tracker.name)
    else
      flash[:alert] = I18n.t('trackers.destroy.failure', name: name)
    end
    redirect_to trackers_path
  end
end
