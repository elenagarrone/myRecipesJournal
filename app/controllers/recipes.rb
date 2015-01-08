get '/recipes/new' do
  erb :'recipes/new'
end

post '/recipes' do
  title = params[:title]
  ingredients = params[:ingredients]
  description = params[:description]
  tags = params["tags"].split(" ").map do |tag|
    Tag.first_or_create(:text => tag)
  end

  Recipe.create(:title => title,
  :ingredients => ingredients,
  :description => description,
  :tags => tags)

  redirect to '/'
end
