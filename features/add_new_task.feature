Feature: Add new task
  As a user
  I want to be able to add a new task
  So that I can deal with it later

  Background:
    Given a user "foo" exists with email "foo@foo.com" and password "foopassword"
    And I am on the login page
    When I fill in "foo" for "Login"
    And I fill in "foopassword" for "Password"
    And I press "Log in"
    Then I should be on the dashboard

  Scenario: Add a task to a blank dashboard and visualize it
    Given I am on the dashboard
    When I add a new task called "Do laundry"
    Then I should see "Do laundry"

  @wip
  Scenario: Add a task while in the middle of another task
    Given I am on the dashboard
    When I add a new task called "Random task"
    And I follow "Start" #for "Random task"
    And I should be on the task timer page
    And I should see "Random task"
    When I go to the dashboard
    When I add a new task called "Another random task"
    Then I should see "Another random task"

  Scenario: Add more tasks than alotted for one day
    Given I am on the dashboard
    And I add 5 different tasks (max the daily task limit)
    And I add a new task called "Task 1"
    And I add a new task called "Task 2"
    And I add a new task called "Task 3"
    And I add a new task called "Task 4"
    And I add a new task called "Task 5"
    When I add a new task called "Do laundry"
    Then I should see "Error: Too many tasks!"
    And I should not see "Do laundry"

  Given there is a calendar with current date October 7, 2010
  And I am currently on this date
  When the clock hits October 8, 2010
  Then I should have a fresh todo list for the new day

  Given there is a calendar
  When I click on the day after the current
  Then I should be on the todo list for that day
