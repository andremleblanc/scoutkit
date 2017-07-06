class CreateHashtagTracker
  include Interactor

  def call
    hashtag = Hashtag.find_or_create_by(name: context.name)
    context.fail!(message: model_error_messages(hashtag)) unless hashtag.persisted?

    context.tracker = HashtagTracker.create(user: context.user, hashtag: hashtag)
    context.fail!(message: I18n.t('hashtag_tracker.validations.hashtag.duplicate', hashtag: hashtag.name)) unless context.tracker.persisted?
  end

  private

  def model_error_messages(object)
    object.errors.full_messages.join(', ')
  end
end
