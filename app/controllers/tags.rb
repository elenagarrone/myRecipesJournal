get '/tags' do
  tag = Tag.first(:text => params[:search_tags])
  @recipes = tag ? tag.recipes : []
  erb :'index'
end
