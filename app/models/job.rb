class Job < ActiveRecord::Base
  belongs_to :user

  def slug
    # Append the job ID to the end so jobs with the same title never conflict
    x = title.downcase.tr('/', '-')
    x.downcase.tr(' ', '-') + "-#{id}"
  end

  def self.find_by_slug(slug)
    Job.all.find { |job| job.slug == slug }
  end

  def self.validate_indeed_url(url)
    url.include?('https://www.indeed.')
  end

  def belongs_to_user?(session_id)
    user_id == session_id
  end
end
