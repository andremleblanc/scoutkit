class HashtagTrackerDecorator < ApplicationDecorator
  def show_path
    hashtag_tracker_path(self)
  end
  alias_method :delete_path, :show_path
end
