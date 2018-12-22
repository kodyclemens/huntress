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
      flash[:blah]
      redirect '/'
    else
      erb :'/users/login'
    end
  end

  get '/admin' do
    if logged_in?
      erb :'/users/admin'
    else
      redirect '/'
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
