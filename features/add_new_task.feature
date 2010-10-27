Feature: Add new task
  As a user
  I want to be able to add a new task
  So that I can deal with it later

  #Background:
    #Given I am logged in as "sample@email.com"

  Scenario: Add a task to a blank dashboard and visualize it
    Given I am on the dashboard
    #And the to-do list for today is blank
    When I follow "New task"
    And I fill in "Description" with "Do laundry"
    And I fill in "Owner" with "0"
    And I press "Create"
    Then I should see "Do laundry"
    #Then I should see a task entry with description “Do laundry”
    #And there should only be one task on the to-do list for today

  Scenario: Add a task while in the middle of another task
    Given I am on a task timer page
    When I go to the dashboard
    And I follow "New task"
    And I fill in "Description" with "Do laundry"
    And I fill in "Owner" with "0"
    And I press "Create"
    Then I should see "Do laundry"

  Scenario: Add more tasks than alotted for one day
    Given I am on the dashboard
    #And my to-do list for today is full
    And I follow "New task"
    And I fill in "Description" with "Do laundry"
    And I fill in "Owner" with "0"
    And I press "Create"
    #Then I should see "Error: Too many tasks!"
    Then I should not see "Do laundry"

  #Given there is a calendar with current date October 7, 2010
  #And I am currently on this date
  #When the clock hits October 8, 2010
  #Then I should have a fresh todo list for the new day

  #Given there is a calendar
  #When I click on the day after the current
  #Then I should be on the todo list for that day
