    15.times do |n|
      email = "example-#{n+1}@sasha.org"
      password  = "password"
      User.create!(email: email,
                   password: password,
                   password_confirmation: password,
                   remember_me: false)
    end

    users = User.all(limit: 6)
    5.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.ads.create!(content: content) }
    end

    users.each do |user|
      user.ads.each do |ad|
        ad.post
        ad.approve
        ad.publish
      end
    end

    email = "admin@gmail.com"
    password  = "programma"
    User.create!(email: email,
                 password: password,
                 password_confirmation: password,
                 remember_me: false,
                 role: "admin")

    email = "user@gmail.com"
    password  = "programma"
    User.create!(email: email,
                 password: password,
                 password_confirmation: password,
                 remember_me: false,
                 role: "user")
