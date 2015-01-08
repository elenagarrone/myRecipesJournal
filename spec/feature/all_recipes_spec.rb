require 'spec_helper'

feature 'A user sees all the recipes available' do

  before(:each) {
    Recipe.create(:title => 'Pesto alla genovese',
    :description => '300 gr of basilico')
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

end
