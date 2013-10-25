require 'spec_helper'

feature 'Creation of new ad type.' do
  let(:admin) { FactoryGirl.create(:admin) }

  before { valid_signin admin }

  scenario 'Admin creates ad type.' do

    click_link 'Profile'

    expect(page).to have_content(admin.email)

    ad_type_name = 'cucumbers'
    click_link 'Ad types'
    fill_in 'ad_type_name', :with => ad_type_name
    click_button 'Ok'

    expect(page).to have_content('added')
    expect(page).to have_content(ad_type_name)
  end

end