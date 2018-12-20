class JobsController < ApplicationController
  get '/jobs' do
    if logged_in?
      user = current_user
      @jobs = user.jobs.all
      
      erb :'/jobs/dashboard'
    else
      redirect '/'
    end
  end

  get '/jobs/new' do
    if logged_in?
      user = current_user
      @jobs = user.jobs.all
      erb :'/jobs/new'
    else
      redirect '/'
    end
  end

  get '/jobs/:slug' do
    if logged_in?
      @job = Job.find_by_slug(params[:slug])
      erb :'/jobs/show'
    else
      redirect '/'
    end
  end

  post '/jobs/new' do
    user = current_user
    params.each do |field|
      redirect '/jobs/new' if field.empty?
    end

    params[:applied] = params[:applied] == 'true'
    user.jobs << Job.create(params)
    redirect '/jobs'
  end
end
