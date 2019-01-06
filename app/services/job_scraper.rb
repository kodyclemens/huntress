require './config/environment'

class JobScraper
  def ScrapeIndeed(job_post_url)

    if job_post_url.include?("/m/viewjob")
      split_url = job_post_url.split("/")
      split_url.delete("m")
      job_post_url = split_url.join("/")
    end

    begin
      doc = Nokogiri::HTML(open(job_post_url))
    rescue OpenURI::HTTPError
      return nil
    end

    title = doc.css(".jobsearch-DesktopStickyContainer h3").text
    company = doc.css(".icl-u-lg-mr--sm")[0].text
    location = doc.css(".jobsearch-DesktopStickyContainer .icl-u-xs-mt--xs .jobsearch-InlineCompanyRating").text.split("-")[1]
    description = doc.css(".jobsearch-JobComponent-description").text
    
    if title.empty?
      nil
    else
      Job.new(title: title, company: company, location: location, description: description)
    end
  end
end
