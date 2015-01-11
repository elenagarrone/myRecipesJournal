require 'spec_helper'
require_relative 'helpers/recipe_helper'
require_relative 'helpers/tags_helper'

include TagHelpers; include RecipeHelpers;

feature 'A user sees all the recipes available' do

  before(:each) {
    Recipe.create(:title => 'Pesto alla genovese',
                  :ingredients => '300 gr of basilico',
                  :description => 'this is the description',
                  :tags => [Tag.first_or_create(:text => 'sauce')])
    Recipe.create(:title => 'Ragu alla bolognese',
                  :ingredients => '300 gr of mince beef',
                  :description => 'this is the description',
                  :tags => [Tag.first_or_create(:text => 'sauce')])
    Recipe.create(:title => 'Grilled eggplants',
                  :ingredients => '300 gr of eggplants',
                  :description => 'this is the description',
                  :tags => [Tag.first_or_create(:text => 'vegetable')])
  }

  scenario 'when opening the homepage' do
    visit '/'
    expect(page).to have_content 'myRecipesJournal'
    expect(page).to have_content 'Pesto alla genovese'
  end

  scenario 'by saerching the tag' do
    search_tags('sauce')
    expect(current_path).to eq '/tags'
  end

  scenario 'with the same tag' do
    search_tags('sauce')
    expect(page).to have_content 'Pesto alla genovese'
    expect(page).to have_content 'Ragu alla bolognese'
    expect(page).not_to have_content 'Grilled eggplants'
  end

end
