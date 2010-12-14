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

  Scenario: Add a task while in the middle of another task
    Given I am on the dashboard
    And I add a new task called "Random task"
    And I follow "Start"
    And I should be on the task timer page
    And I should see "Random task"
    And I go to the dashboard
    When I add a new task called "Another random task"
    Then I should see "Another random task"
    
  Scenario: Adding a duplicate task
    Given I am on the dashboard
    And I add a new task called "unoriginal task"
    And I go to the dashboard
    When I add a new task called "unoriginal task"
    Then I should see "unoriginal task"
