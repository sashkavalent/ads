include ApplicationHelper

def valid_signin(user)
  visit '/'
  click_link 'Login'
  fill_in 'Email',    with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end
