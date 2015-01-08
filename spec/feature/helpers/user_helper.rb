module UserHelpers

  def sign_up(email = "test@test.com",
    password = "testtest",
    password_confirmation = 'testtest')
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_on "Sign up"
  end

  def sign_in(email, password)
    visit '/session/new'
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end
