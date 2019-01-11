ENV['SINATRA_ENV'] ||= 'development'

require 'open-uri'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
Dotenv.load

set :database_file, './database.yml'

require './app/controllers/application_controller'
require_all 'app'
