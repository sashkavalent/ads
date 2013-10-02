namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    99.times do |n|
      email = "example-#{n+1}@sasha.org"
      password  = "password"
      User.create!(email: email,
                   password: password,
                   password_confirmation: password,
                   remember_me: false)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.ads.create!(content: content) }
    end
  end
end