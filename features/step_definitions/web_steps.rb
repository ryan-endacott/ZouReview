
# My own custom web steps!  That may not belong to any particular feature or area.



# Taken from original cucumber web_steps
Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /I should see a success message/ do
  page.should have_css('.alert-success')
end

Then /I should see an error message/ do
  page.should have_css('.alert-error')
end


