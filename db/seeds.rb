case Rails.env
when "development"
  user = FactoryGirl.create(:user, email: 'andre.leblanc88@gmail.com', password: 'abcd1234')

  yoga = FactoryGirl.create(:hashtag, name: 'yoga')
  HashtagTracker.create!(user: user, hashtag: yoga)

  AccountTracker.create!(user: user, account: 'charity.grace')  
end
