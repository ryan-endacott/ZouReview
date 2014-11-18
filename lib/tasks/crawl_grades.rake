require_relative '../grade_crawler.rb'

task :crawl_grades do
  puts 'Starting grade crawl...'
  puts GradeCrawler.get_grade_data('FS2012')
  puts 'Finished grade crawl.'
end
