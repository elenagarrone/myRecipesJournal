require 'spec_helper'

feature 'A user sees all the recipes available' do

  before(:each) {
    Recipe.create(:title => 'Pesto alla genovese',
    :ingredients => '300 gr of basilico',
    :description => 'this is the description')
  }

  scenario 'when opening the homepage' do
    visit '/'
    expect(page).to have_content 'myRecipesJournal'
    expect(page).to have_content 'Pesto alla genovese'
  end

end

feature 'A user can add a recipe' do

  scenario 'when opening the homepage' do
    visit '/'
    expect(page).to have_link 'Add Recipe'
  end

  scenario "by clicking on 'Add Recipe'" do
    visit '/'
    click_on 'Add Recipe'
    expect(page).to have_css 'form#new_recipe'
    expect(page).to have_content 'Enter a new recipe:'
  end

  scenario 'and filling up the form' do
    visit '/recipes/new'
    fill_in :title, with: 'Pesto alla genovese'
    fill_in :description, with: '300 gr of basilico'
  end

end
