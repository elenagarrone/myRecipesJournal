get '/' do
  @recipes = Recipe.all
  erb :index
end
