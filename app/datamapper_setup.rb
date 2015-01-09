env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/myrecipesjournal_#{env}")

require_relative 'models/user.rb'
require_relative 'models/recipe.rb'
require_relative 'models/tag.rb'

DataMapper.finalize
DataMapper.auto_upgrade!
