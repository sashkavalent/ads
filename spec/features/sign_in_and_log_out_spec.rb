require "spec_helper"

feature "Sign in and log out." do
  let(:user) { FactoryGirl.create(:user) }

  scenario "User signs in." do
    visit "/"
    click_link "Login"

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Logout")

    click_link "Logout"

    expect(page).to have_content("Signed out successfully.")
    expect(page).to have_content("Login")
    expect(page).to have_content("Sign up")
  end

end
