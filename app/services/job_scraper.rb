require './config/environment'

class JobScraper
  def ScrapeIndeed(job_post_url)
    doc = Nokogiri::HTML(open(job_post_url))
    # doc = Nokogiri::HTML(open("https://www.indeed.com/viewjob?jk=020b29cbee251c60"))
    # doc = Nokogiri::HTML(open("https://www.indeed.com/cmp/The-Doyle-Group/jobs/Lead-Software-Engineer-1ee43d45c20a79bc"))
    title = doc.css(".jobsearch-DesktopStickyContainer h3").text
    company = doc.css(".icl-u-lg-mr--sm")[0].text
    location = doc.css(".jobsearch-DesktopStickyContainer .icl-u-xs-mt--xs .jobsearch-InlineCompanyRating").text.split("-")[1]
    description = doc.css(".jobsearch-JobComponent-description").text
    Job.new(title: title, company: company, location: location, description: description)
  end
end
