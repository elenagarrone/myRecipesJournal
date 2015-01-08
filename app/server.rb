require 'sinatra'
require 'sinatra/partial'
require_relative 'helpers/app.rb'
require 'data_mapper'
require_relative 'datamapper_setup'
require 'rack-flash'
require_relative 'controllers/app'
require_relative 'controllers/recipes'
require_relative 'controllers/session'
require_relative 'controllers/tags'
require_relative 'controllers/users'
use Rack::Flash, :sweep => true

enable :sessions
set :session_secret, 'super secret'
set :partial_template_engine, :erb
set :public_folder, Proc.new { File.join(root, '..', 'public') }
