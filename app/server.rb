require 'sinatra'
require 'sinatra/partial'
require_relative 'helpers/app.rb'
require 'data_mapper'
require_relative 'datamapper_setup'

enable :sessions
set :session_secret, 'super secret'
set :partial_template_engine, :erb
set :public_folder, Proc.new { File.join(root, '..', 'public') }


get '/' do
  @recipes = Recipe.all
  erb :index
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user = User.create(:email => params[:email],
  :password => params[:password])
  session[:user_id] = user.id
  redirect to '/'
end
