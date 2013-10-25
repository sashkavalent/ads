AdType.create!(name: 'Auto')
AdType.create!(name: 'Real estate')
AdType.create!(name: 'Animals')
15.times do |n|
  email = Faker::Internet.email
  password  = 'password'
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               remember_me: false)
end

users = User.all(limit: 6)
5.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.ads.create!(content: content,
    ad_type_id: AdType.first.id) }
end

users.each do |user|
  user.ads.each do |ad|
    ad.post
    ad.approve
    ad.publish
  end
end

email = 'admin@gmail.com'
password  = 'programma'
User.create!({ email: email,
             password: password,
             password_confirmation: password,
             remember_me: false,
             role: 'admin' }, :as => :admin)

email = 'user@gmail.com'
password  = 'programma'
User.create!(email: email,
             password: password,
             password_confirmation: password,
             remember_me: false)
