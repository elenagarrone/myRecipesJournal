require 'spec_helper'

feature "User signs up" do

  scenario "when a new user visit the site" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, test@test.com")
    expect(User.first.email).to eq("test@test.com")
  end

  def sign_up(email = "test@test.com",
    password = "testtest")
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button "Sign up"
  end

end
