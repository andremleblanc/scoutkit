class InstagramService
  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def recent_posts_for_hashtag(name)
    response = client.media_with_hashtag(name, access_token)
    response['data']
  end

  def recent_posts_for_user(user_id)
    response = client.media_for_user(user_id, access_token)
    response['data']
  end

  # TODO: Test, opt param, etc.
  def recent_users(name, ids = [])
    ids = recent_posts_for_hashtag(name).map{ |post| post.dig 'user', 'id' }.uniq
    ids.map{ |id| user_info(id) }
  end

  def search(name)
    response = client.search(name, access_token)
    response['data']
  end

  def user_info(id)
    response = client.user(id, access_token)
    response['data']
  end

  private

  def client
    InstagramFacade
  end
end
