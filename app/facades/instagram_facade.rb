class InstagramFacade
  SHORT_TTL = Rails.application.secrets.dig :cache, :ttl, :short
  LONG_TTL = Rails.application.secrets.dig :cache, :ttl, :long

  class << self
    def media_with_hashtag(name, access_token)
      # TODO: Wrap in helper
      Rails.cache.fetch("media_with_hashtag/#{name}", expires_in: SHORT_TTL) do
        Rails.logger.info "cache miss for media_with_hashtag/#{name}"
        get("/tags/#{name}/media/recent?access_token=#{access_token}")
      end
    end

    def user(user_id, access_token)
      # TODO: Wrap in helper
      Rails.cache.fetch("user/#{user_id}", expires_in: LONG_TTL) do
        Rails.logger.info "cache miss for user/#{user_id}"
        get("/users/#{user_id}/?access_token=#{access_token}")
      end
    end

    private

    def build_uri(path)
      URI("https://api.instagram.com/v1#{path}")
    end

    def get(path)
      response = Net::HTTP.get(build_uri(path))
      JSON.parse(response)
    end
  end
end
