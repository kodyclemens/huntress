class JobsController < ApplicationController

  use Rack::Flash

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
      if @job.belongs_to_user?(session[:id])
        erb :'/jobs/show'
      else
        flash[:error] = "Unknown job URL."
        redirect '/jobs'
      end
    else
      @logged_in = false
      redirect '/'
    end
  end

  get '/jobs/:slug/edit' do
    # Ensure only owning user can see a job
    if logged_in?
      @logged_in = true
      @job = Job.find_by_slug(params[:slug])
      if @job.belongs_to_user?(session[:id])
        erb :'/jobs/edit'
      else
        flash[:error] = "Unknown job URL."
        redirect '/jobs'
      end
    else
      @logged_in = false
      redirect '/'
    end
  end

  post '/jobs/new' do
    user = current_user
    params.each do |field|
      if field[1].empty?
        flash[:error] = "All fields must be filled out."
        redirect '/jobs/new' 
      end
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
        flash[:notice] = "#{scraped_job[:title]} was added to your dashboard."
        redirect '/jobs/new'
      end
      redirect '/jobs/new'
    else
      flash[:error] = "Invalid URL provided."
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
      if params[:applied].nil?
        flash[:error] = "Please select application status."
        redirect "/jobs/#{slug}"
      end
    end

    params[:applied] = params[:applied] == 'true'
    @job.note = params[:note]
    @job.applied = params[:applied]
    @job.save
    flash[:notice] = "Successfully updated #{@job.title}!"
    redirect "/jobs"
  end
end
