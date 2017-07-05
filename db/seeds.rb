case Rails.env
when "development"
  user = FactoryGirl.create(:user, email: 'andre.leblanc88@gmail.com', password: 'abcd1234')
  yoga = FactoryGirl.create(:hashtag, name: 'yoga')
  FactoryGirl.create(:hashtag_tracker, user: user, hashtag: yoga)
end
