# encoding: utf-8

def create_by_type(items, type)
  items.each { |item| type.create!(name: item) }
end

def create_currencies
  currencies = ['$', 'byr', '€']
  create_by_type(currencies, Currency)
end

def create_ad_types
  ad_types = ['Buy', 'Sell', 'Exchange']
  create_by_type(ad_types, AdType)
end

def create_sections
  sections = ['Technique', 'Auto', 'Real estate']
  create_by_type(sections, Section)
end

def create_places
  places = ['Minsk', 'Minskaya oblast', 'Vitebskaya oblast',
    'Brestskaya oblast', 'Gomelskaya oblast', 'Mogilevskaya oblast',
    'Grodnenskaya oblast']
  create_by_type(places, Place)
end

def create_keywords
  keywords = ['blue', 'cool', 'ruby']
  create_by_type(keywords, Keyword)
end

def create_subsections
  names = ['Phones', 'Laptops', 'Tablets', 'Cars',
    'Spares', 'Accessories', 'Houses', 'Flats', 'Land']
  names.each_with_index do
    |item, index| Subsection.create!(name: item, section_id: index/3 + 1)
  end
end

def create_users
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

def create_ads
  user = User.find_by_email('user@gmail.com')
  content = 'Added by seed ad.'
  ad = user.ads.create!(content: content, ad_type_id: 1, place_id: 1, subsection_id: 1, currency_id: 1, price: 99)
  ad.created_at = Time.now + 10.second
  ad.keywords << Keyword.all
  ad.save

  users = User.where('first_name != ?', 'just').limit(6)
  5.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.ads.create!(content: content,
      ad_type_id: Random.rand(3) + 1, place_id: Random.rand(6) + 1,
      subsection_id: Random.rand(9) + 1, currency_id: Random.rand(3) + 1,
      price: (Random.rand(50) + 1)*100 - 1) }
  end

  Ad.all.each do |ad|
    ad.post
    ad.approve
    ad.publish
  end

end

create_currencies
create_ad_types
create_places
create_sections
create_subsections
create_users
create_keywords
create_ads
