require 'spec_helper'

feature 'Registration.' do

  scenario 'User registers on the site.' do
    visit '/'
    click_link 'Sign up'

    fill_in 'First name', :with => 'sasha'
    fill_in 'Last name', :with => 'kasha'
    fill_in 'Email', :with => 'user123@gmail.com'
    fill_in 'Password', :with => 'programma'
    fill_in 'Password confirmation', :with => 'programma'
    click_button 'Sign up'

    expect(page).to have_content('Welcom')
    expect(page).to have_content('Logout')
  end

end
