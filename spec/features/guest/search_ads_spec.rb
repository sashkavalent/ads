require 'spec_helper'
require 'support/sphinx'

feature 'Searching and sorting ads.' do

  scenario 'Guest search ads by keyword.' do

    index
    visit '/'

    expect(page).not_to have_selector('a', text: 'Added by seed ad.')

    fill_in 'key_word', with: 'added by seed ad'
    click_button 'search'

    expect(page).to have_selector('a', text: 'Added by seed ad.')

  end

  scenario 'Guest search ads by ad type.' do

    visit '/'

    page.select('Auto', from: 'ad_type_id')
    click_button 'search'

    expect(page).to have_css('.ad_type', text: 'Auto')
    expect(page).not_to have_css('.ad_type', text: 'Animals')
    expect(page).not_to have_css('.ad_type', text: 'Real estate')

  end

  scenario 'Guest sort ads by "created at".' do

    visit '/'

    expect(page).not_to have_selector('a', text: 'Added by seed ad.')
    click_link '4'
    expect(page).to have_selector('a', text: 'Added by seed ad.')

    page.select('Older first', from: 'created_at')
    click_button 'search'
    expect(page).to have_selector('a', text: 'Added by seed ad.')

    click_link '4'
    expect(page).not_to have_selector('a', text: 'Added by seed ad.')

  end

end
