require 'grade_crawler'

Given /I fill in a[n]? (in)?correct password/ do |incorrect|
  fill_in(:password, :with => ENV['SECRET_PASSWORD']) unless incorrect
end

And /I submit with term "(.*)"/ do |term|

  stub_request(:any, 'https://musis1.missouri.edu/gradedist/mu_grade_dist_intro.cfm')
    .to_return(:body => File.new(Rails.root.join('spec', 'support', 'sample_grade_page_2.html')), :status => 200)
  fill_in(:term, :with => term)
  click_button('Submit')

end

Then /there should (not )?be sections with "(.*)"/ do |none, term|
  # Check database for new sections with that term if not none
  if none
    Section.where(:term => term).should be_empty
  else
    Section.where(:term => term).should_not be_empty
  end

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
