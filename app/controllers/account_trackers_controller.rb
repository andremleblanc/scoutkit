class AccountTrackersController < ApplicationController
  skip_after_action :verify_authorized, only: :create

  def show
    tracker = AccountTracker.find(params[:id])
    authorize tracker
    @presenter = AccountTrackers::ShowPresenter.new(tracker)
  end

  def create
    result = CreateAccountTracker.call(merged_params)
    tracker = result.tracker

    if result.success?
      flash[:success] = I18n.t('trackers.create.success', name: tracker.name)
      redirect_to account_tracker_path(result.tracker)
    else
      flash[:alert] = result.message
      redirect_to new_tracker_path
    end
  end

  def destroy
    tracker = AccountTracker.find(params[:id])
    authorize tracker

    if tracker.destroy
      flash[:success] = I18n.t('trackers.destroy.success', name: tracker.name)
    else
      flash[:alert] = I18n.t('trackers.destroy.failure', name: tracker.name)
    end
    redirect_to trackers_path
  end

  private

  def merged_params
    tracker_params.merge(user: current_user)
  end

  def tracker_params
    params.require(:tracker).permit(:account, :name)
  end
end
