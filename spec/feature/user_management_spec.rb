require 'spec_helper'
require_relative 'helpers/user_helper'

include UserHelpers

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

  scenario 'with a password which is not long enough' do
    expect{ sign_up }.to change(User, :count).by(1)
    expect{ sign_up('test@test.com', 'test', 'test') }.to change(User, :count).by(0)
    expect(page).to have_content "Password must be between 8 and 10 characters long"
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

  scenario 'with a blank or incorrect email' do
    expect{ sign_in('test', 'testtest') }.to change(User, :count).by(0)
    expect(page).to have_content "Either email or password is incorrect"
  end

end

feature 'User signs out' do

  before(:each) do
    User.create(:email => "test@test.com",
    :password => 'testtest',
    :password_confirmation => 'testtest')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'testtest')
    click_button "Sign out"
    expect(page).to have_content("Thank you for visiting!")
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end
