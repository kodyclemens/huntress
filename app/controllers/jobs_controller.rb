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

  get '/jobs/:slug/edit' do
    if logged_in?
      @logged_in = true
      @job = Job.find_by_slug(params[:slug])
      erb :'/jobs/edit'
    else
      @logged_in = false
      redirect '/'
    end
  end

  post '/jobs/new' do
    user = current_user
    params.each do |field|
      redirect '/jobs/new' if field[1].empty?
    end

    params[:applied] = params[:applied] == 'true'
    user.jobs << Job.create(params)
    redirect '/jobs'
  end

  post '/jobs/new/scraped' do
    # This needs cleaned up.
    # Merge into jobs/new? Need to validate user input to accept only proper job URL
    if Job.validate_indeed_url(params[:url])
      user = current_user
      scraper = JobScraper.new
      scraped_job = scraper.ScrapeIndeed(params[:url])
      if !scraped_job.nil?
        scraped_job.user_id = user.id
        scraped_job.applied = params[:applied] == 'true'
        scraped_job.save
        redirect '/jobs'
      end
      redirect '/jobs/new'
    else
      redirect '/jobs/new'
    end
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
    slug = @job.slug
    params.each do |field|
      redirect "/jobs/#{slug}" if field.empty? || params[:applied].nil?
    end
    params[:applied] = params[:applied] == 'true'
    @job.note = params[:note]
    @job.applied = params[:applied]
    @job.save
    redirect "/jobs"
  end
end
