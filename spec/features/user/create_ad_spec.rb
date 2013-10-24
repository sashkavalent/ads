require 'spec_helper'

feature 'Creation of new ad.' do
  let(:user) { FactoryGirl.create(:user) }

  before { valid_signin user }

  scenario 'User creates ad.' do

    click_link 'Profile'

    expect(page).to have_content(user.email)

    ad_content = 'Selling turnips.'
    fill_in 'ad_content', :with => ad_content
    select 'Auto', :from => 'ad_ad_type_id'
    click_button 'Ok'

    expect(page).to have_content('added')
    expect(page).to have_content(ad_content)
  end

end
