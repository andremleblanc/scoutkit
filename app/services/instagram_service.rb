class InstagramService
  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def recent_posts(name)
    response = client.media_with_hashtag(name, access_token)
    response['data']
  end

  # TODO: Test, opt param, etc.
  def recent_users(name, ids = [])
    # TODO: Don't make the recent posts call from the ShowPresenter
    #   Can't memoize so name could be different
    #   Caching?
    # TODO: Make sure get min x users(need to go through pages)
    ids = recent_posts(name).map{ |post| post.dig 'user', 'id' }.uniq
    ids.map{ |id| client.user(id, access_token)['data'] }
  end

  private

  def client
    InstagramFacade
  end
end
