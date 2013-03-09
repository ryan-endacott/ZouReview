

Given /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
    c = Course.new
    c.title = course[:title]
    c.number = course[:number]
    # Unfortunate hack..... Because avg_gpa can only be set privately
    # (rightly so, but sucks for testing...)
    c.send(:avg_gpa=, course[:avg_gpa])
    c.save!
  end
end

Given /^pagination for courses is set to (\d+)$/ do |num|
  Course.per_page = num
end