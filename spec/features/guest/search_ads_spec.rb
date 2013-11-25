require 'spec_helper'
require 'support/sphinx'
require 'database_cleaner'

feature 'Searching and sorting ads.' do

  let(:user) { create(:user) }

  before do

    DatabaseCleaner.clean
    DatabaseCleaner.strategy = :truncation

    create(:ad_type)
    create(:place)
    create(:section)
    create(:subsection)
    create(:currency)

    5.times do
      ad = user.ads.build(content: Faker::Lorem.words[1],
        ad_type_id: rand(AdType.count) + 1, place_id: 1,
        subsection_id: 1, currency_id: 1)
      ad.post
      ad.approve
      ad.publish
      ad.save
    end
    @ad = Ad.first
    index

  end

  scenario 'Guest searches ad by keyword.' do

    visit '/'

    expect(page).to have_selector('a', text: @ad.content)

    fill_in 'key_word', with: Faker::Name.first_name
    click_button 'search'
    expect(page).not_to have_selector('a', text: @ad.content)

    fill_in 'key_word', with: @ad.content
    click_button 'search'
    expect(page).to have_selector('a', text: @ad.content)

  end

end
