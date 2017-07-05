module HashtagTrackers
  class ShowPresenter
    attr_reader :tracker

    def initialize(tracker)
      @tracker = tracker
    end

    def name
      tracker.name
    end

    def recent_posts
      @recent_posts ||= instagram_client.recent_posts(tracker.name)
    end

    def recent_users
      @recent_users ||= instagram_client.recent_users(tracker.name)
    end

    def instagram_client
      instagram_client ||= InstagramService.new(tracker.access_token)
    end
  end
end
