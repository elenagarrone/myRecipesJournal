require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/myrecipesjournal_#{env}")

require_relative 'models/recipe.rb'

DataMapper.finalize
DataMapper.auto_upgrade!

set :partial_template_engine, :erb
set :public_folder, Proc.new { File.join(root, '..', 'public') }

get '/' do
  erb :index
end
