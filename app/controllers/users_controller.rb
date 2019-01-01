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

  get '/support' do
    erb :'/users/support'
  end

  get '/admin' do
    if logged_in?
      user = User.find(session[:id])
      if user.role == "admin"
        @users = User.all
        @jobs = Job.all
        erb :'/users/admin'
      else
        redirect '/'
      end
    else
      redirect '/'
    end
  end

  get '/users/:user/edit' do
    if logged_in?
      @user = User.find(session[:id])
      if params[:user] == @user.username
        erb :'/users/edit'
      else
        redirect "/users/#{@user.username}"
      end
    else
      redirect '/'
    end
  end

  patch '/users/:user/edit' do
    @user = User.find_by(username: params[:user])
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save
    redirect "/users/#{@user.username}/edit"
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

  patch '/users/:id/update' do
    id = params[:id].to_i
    User.update(id, role: params[:user][0][:role])
    redirect '/admin'
  end
end
