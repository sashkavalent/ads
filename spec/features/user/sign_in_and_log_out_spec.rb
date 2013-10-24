require 'spec_helper'

feature 'Access to site.' do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'User logs in and logs out.' do
    visit '/'
    click_link 'Login'

    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Logout')
    expect(page).to have_content('Profile')

    click_link 'Logout'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Login')
    expect(page).to have_content('Sign up')
  end

end
