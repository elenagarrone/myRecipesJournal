get '/recipes/new' do
  erb :'recipes/new'
end

post '/recipes' do
  Recipe.create_from_params(params)
  redirect to '/'
end
