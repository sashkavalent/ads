FactoryGirl.define do

  factory :admin, class: User do
    email    "admin@example.com"
    password "12345678"
    password_confirmation "12345678"
    remember_me false
    role "admin"
  end
end
