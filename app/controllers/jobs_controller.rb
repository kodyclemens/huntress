class JobsController < ApplicationController
  get '/jobs' do
    if logged_in?
      user = User.find(session[:id])
      @jobs = user.jobs.all
      erb :'/jobs/dashboard'
    else
      redirect '/'
    end
  end
end