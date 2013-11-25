FactoryGirl.define do

  factory :subsection do
    name Faker::Lorem.words[1]
    section_id 1
  end

end
