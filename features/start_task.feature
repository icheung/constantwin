Feature: Start task
  As a user
    I want to be able to start one of the tasks from my list of tasks
    So that I can begin working on that task
    
  Background:
    Given a user "iriswin" exists with email "iris@constantwin.com" and password "fast1car"
    And I am on the login page
    When I fill in "iriswin" for "Login"
    And I fill in "fast1car" for "Password"
    And I press "Log in"
    Then I should be on the dashboard

  Scenario: I start the task
    Given I am on the dashboard
    When I start timing "taskEntry7"
    Then I should be on the task timer page
    And I should see "Do laundry"
    And I should see a timer entry field

  Scenario:
    Given I am on the dashboard
    When I start timing taskEntry7
    Then I should see "do laundry"
    And I should see a timer entry field

