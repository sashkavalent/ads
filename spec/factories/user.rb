FactoryGirl.define do

  factory :user do
    first_name 'sasha'
    last_name 'kasha'
    email    'sasha@example.com'
    password '12345678'
    password_confirmation '12345678'
    remember_me false
  end

  factory :admin, class: User do
    first_name 'sasha'
    last_name 'kasha'
    email    'admin@example.com'
    password '12345678'
    password_confirmation '12345678'
    remember_me false
    role 'admin'
  end
end
