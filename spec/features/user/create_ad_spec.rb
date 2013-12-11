#encoding: utf-8

require 'spec_helper'

feature 'Creation of new ad.', :js => true do

  scenario 'User creates ad with photos.' do

    ad_type = create(:ad_type)
    place = create(:place)
    section = create(:section)
    subsection = create(:subsection)
    currency = create(:currency)

    user = create(:user)
    valid_signin user

    click_link 'Profile'

    expect(page).to have_content(user.name)
    ad_content = 'Selling turnips.'

    click_on 'create new ad'
    fill_in 'ad_content', :with => ad_content
    fill_in 'ad_price', :with => '100'

    select ad_type.name, :from => 'ad_ad_type_id'
    select place.name, :from => 'ad_place_id'
    select subsection.name, :from => 'ad_subsection_id'
    select currency.name, :from => 'ad_currency_id'

    2.times do |i|

      click_on 'Add photo'

      path_to_file = '/home/sasha/Изображения/wilde.jpg'
      page.all('.fields')[i].find("input[type='text']").set('photo')
      page.all('.fields')[i].find("input[type='file']").set(path_to_file)
    end

    click_button 'Ok'
    expect(page).to have_content('created')

    click_on 'Profile'
    expect(page).to have_selector('img')
    expect(page).to have_content(ad_content)
  end

end
