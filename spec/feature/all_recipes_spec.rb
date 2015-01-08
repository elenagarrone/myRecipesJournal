require 'spec_helper'
require_relative 'helpers/recipe_helper'
require_relative 'helpers/tags_helper'

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
    expect(page).not_to have_content 'Melanzane grigliate'
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

  scenario 'by filling up the form' do
    visit '/'
    create_recipe("Pesto alla genovese", "300 gr of basilico", "this is the description", ['sauce', 'Italy'])
    expect(Recipe.count).to eq(1)
    recipe = Recipe.first
    expect(recipe.title).to eq("Pesto alla genovese")
    expect(recipe.ingredients).to eq("300 gr of basilico")
    expect(recipe.description).to eq("this is the description")
  end

  scenario "with a few tags" do
    visit "/"
    create_recipe("Pesto alla genovese", "300 gr of basilico", "this is the description", ['sauce', 'Italy'])
    recipe = Recipe.first
    expect(recipe.tags.map(&:text)).to include("sauce")
    expect(recipe.tags.map(&:text)).to include("Italy")
  end

end
