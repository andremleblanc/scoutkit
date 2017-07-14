class AccountTrackerDecorator < ApplicationDecorator
  def name
    "@#{__getobj__.name}"
  end

  def show_path
    account_tracker_path(self)
  end
  alias_method :delete_path, :show_path
end
