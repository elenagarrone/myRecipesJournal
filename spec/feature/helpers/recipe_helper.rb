def create_recipe(title, ingredients, description, tags = [])
  visit '/recipes/new'
  fill_in :title, with: title
  fill_in :ingredients, with: ingredients
  fill_in :description, with: description
  fill_in :tags, :with => tags.join(' ')
  click_on 'Submit'
end
