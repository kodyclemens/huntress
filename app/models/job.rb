class Job < ActiveRecord::Base
  belongs_to :user

  def slug
    # Append the job ID to the end so jobs with the same title never conflict
    title.downcase.gsub(" ", "-") + "-#{id}"
  end

  def self.find_by_slug(slug)
    Job.all.find{|job| job.slug == slug}
  end
end
