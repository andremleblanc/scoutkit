module AccountTrackers
  class ShowPresenter
    attr_reader :tracker

    def initialize(tracker)
      @tracker = tracker
    end

    def account
      @account ||= tracker.account
    end

    def name
      @name ||= tracker.name
    end

    def recent_posts
      @recent_posts ||= instagram_client.recent_posts_for_user(account.instagram_uid)
    end

    def instagram_client
      @instagram_client ||= InstagramService.new(tracker.access_token_value)
    end
  end
end
