class Job < ActiveRecord::Base
  belongs_to :user

  def slug
    # Append the job ID to the end so jobs with the same title never conflict
    x = title.downcase.gsub("/", "-")
    x = x.downcase.gsub(" ", "-") + "-#{id}"
  end

  def self.find_by_slug(slug)
    Job.all.find{|job| job.slug == slug}
  end

  def self.validate_indeed_url(url)
    url.include?("https://www.indeed.com/")
  end

  def belongs_to_user?(session_id)
    self.user_id == session_id
  end
end
