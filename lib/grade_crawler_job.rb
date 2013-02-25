# Delayed::Job job to process grade crawls in the background
# Start a background grade crawl by doing:
# Delayed::Job.enqueue GradeCrawlerJob.new(term)

require 'grade_crawler'
require 'section_creator'

class GradeCrawlerJob < Struct.new(:term)
  def perform
    print "I'M PERFORMING SIR.  I PROMISE.  Please work heroku."
    data = GradeCrawler.get_grade_data(term)
    section_creator = SectionCreator.new(data)
    section_creator.create_sections!
  end
end