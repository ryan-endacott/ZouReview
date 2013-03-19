
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

Then /I should (not )?see "(.*)"$/ do |should_not_see, items|
  items.split(',').collect(&:strip).each do |item|
    if should_not_see
      page.should_not have_content(item)
    else
      page.should have_content(item)
    end
  end
end

Then /^I click on page (\d+)$/ do |page|
  within(first(:css, ".pagination")) do
    click_link(page)
  end 
end

Then /^"(.*)" should be visible before "(.*)"/ do |first, second|
  page.body.index(first).should < page.body.index(second)
end



