require 'sinatra'
require 'sinatra/partial'
require_relative 'helpers/app.rb'
require 'data_mapper'
require_relative 'datamapper_setup'
require 'rack-flash'

use Rack::Flash, :sweep => true

enable :sessions
set :session_secret, 'super secret'
set :partial_template_engine, :erb
set :public_folder, Proc.new { File.join(root, '..', 'public') }


get '/' do
  @recipes = Recipe.all
  erb :index
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.create(:email => params[:email],
  :password => params[:password],
  :password_confirmation=> params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to '/'
  else
    flash[:notice] = "Sorry, your passwords don't match"
    erb :'users/new'
  end
end

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

get '/tags' do
  tag = Tag.first(:text => params[:search_tags])
  @recipes = tag ? tag.recipes : []
  erb :'index'
end
