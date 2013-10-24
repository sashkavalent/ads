require 'spec_helper'
# Capybara.default_driver = :selenium
feature 'Sign up.' do
  scenario 'User registers on the site.' do
    visit '/'
    click_link 'Sign up'

    fill_in 'Email', :with => 'User@gmail.com'
    fill_in 'Password', :with => 'programma'
    fill_in 'Password confirmation', :with => 'programma'
    click_button 'Sign up'

    expect(page).to have_content('Welcom')
    expect(page).to have_content('Logout')
  end
end
