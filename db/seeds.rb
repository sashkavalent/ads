AdType.create!(name: 'Auto')
AdType.create!(name: 'Real estate')
AdType.create!(name: 'Animals')
15.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  password  = 'password'
  User.create!(first_name: first_name,
               last_name: last_name,
               email: email,
               password: password,
               password_confirmation: password,
               remember_me: false)
end

first_name = 'just'
last_name = 'admin'
email = 'admin@gmail.com'
password  = 'programma'
User.create!({first_name: first_name,
              last_name: last_name,
              email: email,
              password: password,
              password_confirmation: password,
              remember_me: false,
              role: 'admin' }, :as => :admin)

first_name = 'just'
last_name = 'user'
email = 'user@gmail.com'
password  = 'programma'
user = User.create!(first_name: first_name,
             last_name: last_name,
             email: email,
             password: password,
             password_confirmation: password,
             remember_me: false)

content = 'Added by seed ad.'
ad = user.ads.create!(content: content, ad_type_id: 1)
ad.created_at = Time.now - 2.second

ad.post
ad.approve
ad.publish

users = User.where('first_name != ?', 'just').limit(6)
5.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.ads.create!(content: content,
    ad_type_id: Random.rand(3) + 1) }
end

users.each do |user|
  user.ads.each do |ad|
    ad.post
    ad.approve
    ad.publish
  end
end
