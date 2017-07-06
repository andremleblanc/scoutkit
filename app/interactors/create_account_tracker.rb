class CreateAccountTracker
  include Interactor

  def call
    instagram_service = InstagramService.new(context.user.access_token_value)
    name = context.name || context.account

    instagram_uid = instagram_service.search(name).first.try(:[], 'id')
    context.fail!(message: I18n.t('account_tracker.validations.instagram.missing', account: name)) unless instagram_uid.present?

    account = Account.find_or_create_by(name: name, instagram_uid: instagram_uid)
    context.fail!(message: model_error_messages(account)) unless account.persisted?

    context.tracker = AccountTracker.create(user: context.user, account: account)
    context.fail!(message: I18n.t('account_tracker.validations.account.duplicate', account: account.name)) unless context.tracker.persisted?
  end

  private

  def model_error_messages(object)
    object.errors.full_messages.join(', ')
  end
end
