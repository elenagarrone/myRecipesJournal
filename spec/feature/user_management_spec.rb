require 'spec_helper'
require_relative 'helpers/user_helper'

feature "User signs up" do

  scenario "when a new user visit the site" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, test@test.com"
    expect(User.first.email).to eq "test@test.com"
  end

  scenario 'with a wrong password' do
    expect{ sign_up('test@test.com', 'testtest', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq '/users'
    expect(page).to have_content "Password does not match the confirmation"
  end

  scenario 'with an email that is already taken' do
    expect{ sign_up }.to change(User, :count).by(1)
    expect{ sign_up }.to change(User, :count).by(0)
    expect(page).to have_content "Email is already taken"
  end

end

feature "User signs in" do

  before(:each) do
    User.create(:email => "test@test.com",
    :password => 'testtest',
    :password_confirmation => 'testtest')
  end

  scenario 'when visiting the site' do
    visit '/'
    expect(page).not_to have_content "Welcome, test@test.com"
    sign_in('test@test.com', 'testtest')
    expect(page).to have_content "Welcome, test@test.com"
  end

  scenario 'when entering the incorrect user info' do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end
