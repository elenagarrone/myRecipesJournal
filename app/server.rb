require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/myrecipesjournal_#{env}")

require_relative 'models/user.rb'
require_relative 'helpers/app.rb'

DataMapper.finalize
DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'
set :partial_template_engine, :erb
set :public_folder, Proc.new { File.join(root, '..', 'public') }


get '/' do
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
