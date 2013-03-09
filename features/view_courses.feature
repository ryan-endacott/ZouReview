Feature: View a list of courses sorted by various parameters
 
  As a Mizzou student
  In order to get information on all courses
  I want to view a list of all courses available sorted by various parameters

Background:

  Given the following courses exist:
  |title       |number       |avg_gpa |
  |English     |1000         |1.8     |
  |Calculus    |1700         |3.8     |
  |Algebra     |1200         |2.8     |

  Given pagination for courses is set to 2
  And I am on the courses page

Scenario: View courses by default should paginate
  Then I should see "English, Calculus"
  And I should not see "Algebra"
  And I click on page 2
  Then I should see "Algebra"
  And I should not see "English, Calculus"


