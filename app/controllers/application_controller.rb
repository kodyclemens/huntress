require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET')
  end

  def logged_in?
    session[:id] != nil
  end

  def current_user
    if logged_in?
      user = User.find(session[:id])
      user
    end
  end

  get '/' do
    # binding.pry
    @logged_in = logged_in?
    if @logged_in
      redirect '/jobs'
    else
      erb :welcome
    end
  end
end
