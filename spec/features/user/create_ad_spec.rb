#encoding: utf-8

require 'spec_helper'

feature 'Creation of new ad.', :js => true do

  scenario 'User creates ad with photos.' do

    ad_type = create(:ad_type)
    user = create(:user)
    valid_signin user

    click_link 'Profile'

    expect(page).to have_content(user.name)
    ad_content = 'Selling turnips.'
    fill_in 'ad_content', :with => ad_content
    select ad_type.name, :from => 'ad_ad_type_id'

    2.times do |i|

      click_on 'Add photo'

      path_to_file = '/home/sasha/Изображения/wilde.jpg'
      page.all('.fields')[i].find("input[type='text']").set('photo')
      page.all('.fields')[i].find("input[type='file']").set(path_to_file)
    end

    click_button 'Ok'

    expect(page).to have_selector('img')
    expect(page).to have_content('added')
    expect(page).to have_content(ad_content)
  end

end
