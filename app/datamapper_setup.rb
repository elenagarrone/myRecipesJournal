env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/myrecipesjournal_#{env}")

require_relative 'models/user.rb'
require_relative 'models/recipe.rb'

DataMapper.finalize
DataMapper.auto_upgrade!
