def sign_up(email = "test@test.com",
  password = "testtest",
  password_confirmation = 'testtest')
  visit '/users/new'
  fill_in :email, :with => email
  fill_in :password, :with => password
  fill_in :password_confirmation, :with => password_confirmation
  click_button "Sign up"
end
