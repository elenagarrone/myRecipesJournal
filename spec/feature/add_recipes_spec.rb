require 'spec_helper'
require_relative 'helpers/user_helper'

include UserHelpers;

feature 'A user add a recipe' do

  before(:each) do
    User.create(:email => "test@test.com",
    :password => 'testtest',
    :password_confirmation => 'testtest')
  end

  scenario 'when signed in' do
    sign_in('test@test.com', 'testtest')
    expect(page).to have_link 'Add Recipe'
  end

  scenario 'when signed in' do
    visit '/'
    expect(page).not_to have_link 'Add Recipe'
  end

  scenario 'when opening the homepage' do
    sign_in('test@test.com', 'testtest')
    expect(page).to have_link 'Add Recipe'
  end

  scenario "by clicking on 'Add Recipe'" do
    sign_in('test@test.com', 'testtest')
    click_on 'Add Recipe'
    expect(page).to have_css 'form#new_recipe'
    expect(page).to have_content 'Enter a new recipe:'
  end

  scenario 'by filling up the form' do
    sign_in('test@test.com', 'testtest')
    create_recipe("Pesto alla genovese", "300 gr of basilico", "this is the description", ['sauce', 'Italy'])
    expect(Recipe.count).to eq(1)
    recipe = Recipe.first
    expect(recipe.title).to eq("Pesto alla genovese")
    expect(recipe.ingredients).to eq("300 gr of basilico")
    expect(recipe.description).to eq("this is the description")
  end

  scenario "with a few tags" do
    sign_in('test@test.com', 'testtest')
    create_recipe("Pesto alla genovese", "300 gr of basilico", "this is the description", ['sauce', 'Italy'])
    recipe = Recipe.first
    expect(recipe.tags.map(&:text)).to include("sauce")
    expect(recipe.tags.map(&:text)).to include("Italy")
  end

end
