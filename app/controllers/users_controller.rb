class UsersController < ApplicationController
  get '/signup' do
    erb :'/users/signup'
  end
  
  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/login' do
    if logged_in?
      redirect '/'
    else
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
