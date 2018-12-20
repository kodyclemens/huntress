class UsersController < ApplicationController
  get '/signup' do
    @logged_in = false
    erb :'/users/signup'
  end
  
  get '/logout' do
    session.clear
    @logged_in = false
    redirect '/'
  end

  get '/login' do
    if logged_in?
      @logged_in = true
      flash[:blah]
      redirect '/'
    else
      @logged_in = false
      erb :'/users/login'
    end
  end

  post '/signup' do
    user = User.create(params)
    session[:id] = user.id
    redirect '/'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user != nil && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/jobs'
    else
      redirect '/login'
    end
  end
end
