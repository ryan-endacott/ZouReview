Feature: Do a grade crawl for a specific term and import to database
 
  As the 1337 Dev and Admin of this application
  In order to quickly send the web crawler off on a quest for more data
  I want to crawl new grade distribution data and add it to the database

Background:

  Given I am on the admin page

Scenario: Crawl a term of grades
  Given I fill in a correct password
  And I submit with term "FS2010"
  Then I should see a success message
  And there should be sections with "FS2010"

Scenario: Invalid password
  Given I fill in an incorrect password
  And I submit with term "FS2010"
  Then I should see an error message
  And there should not be sections with "FS2010"



