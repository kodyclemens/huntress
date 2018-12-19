class UsersController < ApplicationController
  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    user = User.create(params)
    session[:id] = user.id
    redirect '/'
  end
end