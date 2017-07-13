case Rails.env
when :development
  user = FactoryGirl.create(:user, email: 'andre.leblanc88@gmail.com', password: 'abcd1234')

  hashtag = FactoryGirl.create(:hashtag, name: 'yoga')
  HashtagTracker.create!(user: user, hashtag: hashtag)

  account = FactoryGirl.create(:account, name: 'charity.grace')
  AccountTracker.create!(user: user, account: account)
end
