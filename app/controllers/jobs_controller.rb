class JobsController < ApplicationController
  get '/jobs' do
    if logged_in?
      @logged_in = true
      user = current_user
      @jobs = user.jobs.all
      erb :'/jobs/dashboard'
    else
      @logged_in = false
      redirect '/'
    end
  end

  get '/jobs/new' do
    if logged_in?
      @logged_in = true
      user = current_user
      @jobs = user.jobs.all
      erb :'/jobs/new'
    else
      @logged_in = false
      redirect '/'
    end
  end

  get '/jobs/:slug' do
    if logged_in?
      @logged_in = true
      @job = Job.find_by_slug(params[:slug])
      erb :'/jobs/show'
    else
      @logged_in = false
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

  post '/jobs/new/scraped' do
    # This needs cleaned up.
    # Merge into jobs/new? Need to validate user input to accept only proper job URL
    user = current_user
    scraper = JobScraper.new
    scraped_job = scraper.ScrapeIndeed(params[:url])
    scraped_job.user_id = user.id
    scraped_job.applied = params[:applied] == 'true'
    scraped_job.save
    redirect '/jobs'
  end

  delete '/jobs/:slug/delete' do
    @job = Job.find_by_slug(params[:slug])
    if @job.user_id == session[:id]
      @job.destroy
      redirect '/jobs'
    end
  end

  patch '/jobs/:slug/edit' do
    @job = Job.find_by_slug(params[:slug])
    params.each do |field|
      redirect "/jobs/#{@job.slug}" if field.empty?
    end
    params[:applied] = params[:applied] == 'true'
    @job.update(params[:job].first)
    redirect "/jobs"
  end
end
