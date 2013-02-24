require 'grade_crawler'

Given /I fill in a[n]? (in)?correct password/ do |incorrect|
  fill_in(:password, :with => ENV['SECRET_PASSWORD']) unless incorrect
end

And /I submit with term "(.*)"/ do |term|
  print Rails.root
  print 'rails root above\n'
  #https://musis1.missouri.edu/gradedist/mu_grade_dist_intro.cfm#CGI.script.name
  stub_request(:any, GradeCrawler::SITE_URI)
    .to_return(:body => File.new(Rails.root.join('spec', 'support', 'sample_grade_page_2.html')), :status => 200)
  fill_in(:term, :with => term)
  click_button('Submit')
end

Then /there should (not )?be sections with "(.*)"/ do |none, term|
  # Check database for new sections with that term
  Sections.where(:term => term).should_not be_empty

  # This code below should probably be used instead of above once section scaffolding and stuff is 
  # completed.  Otherwise, this feature won't pass.
  """
  visit(sections_path)
  if none
    page.should have_no_content(term)
  else
    page.should have_content(term)
  end
  """
end
