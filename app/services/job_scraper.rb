require './config/environment'

class JobScraper
  def ScrapeIndeed(job_post_url)
    begin
      doc = Nokogiri::HTML(open(job_post_url))
    rescue OpenURI::HTTPError
      return nil
    end
    # doc = Nokogiri::HTML(open("https://duckduckgo.com/?q=bootstrap+grid+wont+go+next+to+one+another&ia=web"))
    title = doc.css(".jobsearch-DesktopStickyContainer h3").text
    # binding.pry
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
