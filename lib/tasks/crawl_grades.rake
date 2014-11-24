require_relative '../grade_crawler.rb'
require 'json'

task :crawl_grades, [:start_term, :end_term, :output_file] do |t, args|
  puts 'Starting grade crawl...'
  results = GradeCrawler.get_grade_data_for_multiple_terms(args[:start_term], args[:end_term])
  output_file = args[:output_file] || 'out/grades.json'
  File.write(output_file, results.to_json)
  puts "Finished grade crawl.  Grades written to #{output_file}."
end
