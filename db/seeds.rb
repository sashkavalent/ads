# encoding: utf-8

def currencies
  Currency.create!(name: '$')
  Currency.create!(name: 'byr')
  Currency.create!(name: '€')
end

def ad_types
  AdType.create!(name: 'Buy')
  AdType.create!(name: 'Sell')
  AdType.create!(name: 'Exchange')
end

def sections
  Section.create!(name: 'Technique')
  Section.create!(name: 'Auto')
  Section.create!(name: 'Real estate')
end

def places
  Place.create!(name: 'Minsk')
  Place.create!(name: 'Minskaya oblast')
  Place.create!(name: 'Vitebskaya oblast')
  Place.create!(name: 'Brestskaya oblast')
  Place.create!(name: 'Gomelskaya oblast')
  Place.create!(name: 'Mogilevskaya oblast')
  Place.create!(name: 'Grodnenskaya oblast')
end

def subsections
  Subsection.create!(name: 'Phones', section_id: 1)
  Subsection.create!(name: 'Laptops', section_id: 1)
  Subsection.create!(name: 'Tablets', section_id: 1)

  Subsection.create!(name: 'Cars', section_id: 2)
  Subsection.create!(name: 'Spares', section_id: 2)
  Subsection.create!(name: 'Accessories', section_id: 2)

  Subsection.create!(name: 'Houses', section_id: 3)
  Subsection.create!(name: 'Flats', section_id: 3)
  Subsection.create!(name: 'Land', section_id: 3)
end

def users
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
end

def ads
  user = User.find_by_email('user@gmail.com')
  content = 'Added by seed ad.'
  ad = user.ads.create!(content: content, ad_type_id: 1, place_id: 1, subsection_id: 1, currency_id: 1, price: 100)
  ad.created_at = Time.now - 2.second

  ad.post
  ad.approve
  ad.publish

  users = User.where('first_name != ?', 'just').limit(6)
  5.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.ads.create!(content: content,
      ad_type_id: Random.rand(3) + 1, place_id: Random.rand(6) + 1,
      subsection_id: Random.rand(9) + 1, currency_id: Random.rand(3) + 1,
      price: Random.rand(50)*100 - 1) }
  end

  users.each do |user|
    user.ads.each do |ad|
      ad.post
      ad.approve
      ad.publish
    end
  end
end

currencies
ad_types
places
sections
subsections
users
ads
