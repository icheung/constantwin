Feature: Add new task
  As a user
  I want to be able to add a new task
  So that I can deal with it later

  Background:
    #Given I am logged in as "sample@email.com"

  @wip
  Scenario: Add a task to a blank dashboard and visualize it
    Given I am on the dashboard
    And I log in as "test" with password "testaccount"
    #Then show me the page
    #When I add a new task called "Do laundry"
    #Then I should see "Do laundry"
    #And there should only be one task on the to-do list for today

  Scenario: Add a task while in the middle of another task
    Given I am on the dashboard
    When I add a new task called "Random task"
    And I follow "Start" #for "Random task"
    And I should be on the task timer page
    And I should see "Random task"
    When I go to the dashboard
    When I add a new task called "Another random task"
    Then I should see "Another random task"

  #Scenario: Add more tasks than alotted for one day
  #  Given I am on the dashboard
    # And I add 5 different tasks (max the daily task limit)
  #  And I follow "New task"
  #  And I fill in "Description" with "Task 1"
  #  And I press "Create"
  #  And I follow "Back"
  #  And I follow "New task"
  #  And I fill in "Description" with "Task 2"
  #  And I press "Create"
  #  And I follow "Back"
  #  And I follow "New task"
  #  And I fill in "Description" with "Task 3"
  #  And I press "Create"
  #  And I follow "Back"
  #  And I follow "New task"
  #  And I fill in "Description" with "Task 4"
  #  And I press "Create"
  #  And I follow "Back"
  #  And I follow "New task"
  #  And I fill in "Description" with "Task 5"
  #  And I press "Create"
  #  And I follow "Back"
  #  When I follow "New task"
  #  And I fill in "Description" with "Do laundry"
  #  And I press "Create"
  #  Then I should see "Error: Too many tasks!"
  #  And I should not see "Do laundry"

  #Given there is a calendar with current date October 7, 2010
  #And I am currently on this date
  #When the clock hits October 8, 2010
  #Then I should have a fresh todo list for the new day

  #Given there is a calendar
  #When I click on the day after the current
  #Then I should be on the todo list for that day
