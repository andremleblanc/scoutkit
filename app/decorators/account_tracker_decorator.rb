class AccountTrackerDecorator < ApplicationDecorator
  def show_path
    account_tracker_path(self)
  end
  alias_method :delete_path, :show_path
end
